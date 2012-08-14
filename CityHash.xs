#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

// prevent conflict with stdc++ functions
#undef do_open
#undef do_close

#include <city.h>

#if IVSIZE >= 8
#  define CITY_GET64(SV)    SvUV(SV)
#  define CITY_SET64(SV,N)  (SV) = newSVuv(N)
#else
#  include <stdlib.h>
#  include <sstream>
#  define CITY_GET64(SV)    strtoull(SvPV_nolen((SV), NULL, 0)
#  define CITY_SET64(SV,N)  { std::ostringstream os; os << (N); (SV) = newSVpv(os.str().c_str(), 0); }
#endif

#define swab64(x) \
    ( (((uint64)(x) & 0x00000000000000ff) << 56) | \
      (((uint64)(x) & 0x000000000000ff00) << 40) | \
      (((uint64)(x) & 0x0000000000ff0000) << 24) | \
      (((uint64)(x) & 0x00000000ff000000) <<  8) | \
      (((uint64)(x) & 0x000000ff00000000) >>  8) | \
      (((uint64)(x) & 0x0000ff0000000000) >> 24) | \
      (((uint64)(x) & 0x00ff000000000000) >> 40) | \
      (((uint64)(x) & 0xff00000000000000) >> 56) )

#if BYTEORDER == 0x1234 || BYTEORDER == 0x12345678
#  define CITY_BIGENDIAN(x)  swab64(x)
#elif BYTEORDER == 0x4321 || BYTEORDER == 0x87654321
#  define CITY_BIGENDIAN(x)  (x)
#else
#  error invalid byte order BYTEORDER
#endif

MODULE = String::CityHash		PACKAGE = String::CityHash

SV *
cityhash64(message, ...)
	SV *message

	PROTOTYPE: $;$$
	ALIAS:
		cityhash64_bits = 1
	CODE:
		uint64 city;
		STRLEN len;
		const char *msg = SvPVbyte(message, len);

		switch (items) {
			case 1: {
				city = CityHash64(msg, len);
				break;
			}

			case 2: {
				uint64 seed0 = CITY_GET64(ST(1));

				city = CityHash64WithSeed(msg, len, seed0);
				break;
			}

			default: {
				uint64 seed0 = CITY_GET64(ST(1));
				uint64 seed1 = CITY_GET64(ST(2));

				city = CityHash64WithSeeds(msg, len, seed0, seed1);
				break;
			}
		}

		if (!ix) {
			CITY_SET64(RETVAL, city);
		} else {
			uint64 ret = CITY_BIGENDIAN(city);
			RETVAL = newSVpvn((const char *)&ret, sizeof ret);
		}

	OUTPUT: RETVAL

void
cityhash128(message)
	SV *message

	PROTOTYPE: $
	PPCODE:
		STRLEN len;
		const char *msg = SvPVbyte(message, len);

		uint128 city = CityHash128(msg, len);

		mXPUSHu(Uint128Low64(city));

		if (GIMME == G_ARRAY)
			mXPUSHu(Uint128High64(city));

SV *
cityhash128_bits(message)
	SV *message

	PROTOTYPE: $
	CODE:
		STRLEN len;
		const char *msg = SvPVbyte(message, len);

		uint128 city = CityHash128(msg, len);

		uint64 ret[2];

		ret[0] = CITY_BIGENDIAN(Uint128Low64(city));
		ret[1] = CITY_BIGENDIAN(Uint128High64(city));

		RETVAL = newSVpvn((const char *)&ret, sizeof ret);

	OUTPUT: RETVAL
