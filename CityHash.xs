#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <city.h>
#include <sstream>

MODULE = String::CityHash		PACKAGE = String::CityHash

SV *
cityhash64(message, ...)
	SV *message

	PREINIT:
		uint64 city;

		STRLEN len;
		const char *msg;
	CODE:
		SvGETMAGIC(message);
		msg = SvPV(message, len);

		switch (items) {

			case 2: {
				uint64 seed0 = SvUV(ST(1));

				city = CityHash64WithSeed(msg, len, seed0);
				break;
			}

			case 3: {
				uint64 seed0 = SvUV(ST(1));
				uint64 seed1 = SvUV(ST(2));

				city = CityHash64WithSeeds(msg, len, seed0, seed1);
				break;
			}

			default: {
				city = CityHash64(msg, len);
			}
		}

		RETVAL = newSVuv(city);

	OUTPUT:
		RETVAL

SV *
cityhash128(message)
	SV *message

	PREINIT:
		uint128 city;
		std::ostringstream city_s;

		STRLEN len;
		const char *msg;
	CODE:
		SvGETMAGIC(message);
		msg = SvPV(message, len);

		city = CityHash128(msg, len);
		city_s << Uint128Low64(city) << Uint128High64(city);

		RETVAL = newSVpv(city_s.str().c_str(), 0);

	OUTPUT:
		RETVAL
