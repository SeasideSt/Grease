running
basicCheck: aClass

	^ aClass allSuperclasses anySatisfy: [ :each | self classNames includes: each name ]