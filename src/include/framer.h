#pragma once

#if defined(_WIN32)
	#ifdef FRAMER_SHARED	// Export symbols if its Windows && BUILD_SHARED_LIBS is set
		#ifdef FRAMER_EXPORT
			#define FRAMER_API __declspec(dllexport)
		#else
			#define FRAMER_API __declspec(dllimport)
		#endif // FRAMER_EXPORT
	#else
		#define FRAMER_API
	#endif
#else
	#define FRAMER_API __attribute__((visibility("default")))
#endif // _WIN32 && FRAMER_SHARED
