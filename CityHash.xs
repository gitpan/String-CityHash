#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <city.h>

MODULE = String::CityHash		PACKAGE = String::CityHash

SV *
cityhash64(message, ...)
	SV *message

	PREINIT:
		uint64 city;
		uint64 seed0;
		uint64 seed1;

		STRLEN len;
		const char *msg;
	CODE:
		SvGETMAGIC(message);
		msg = SvPV(message, len);

		switch (items) {

			case 2: {
				seed0 = SvUV(ST(1));

				city = CityHash64WithSeed(msg, len, seed0);
				break;
			}

			case 3: {
				seed0 = SvUV(ST(1));
				seed1 = SvUV(ST(2));

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
