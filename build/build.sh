#!/bin/bash
echo --- START OF BUILD ---

cd ~/workspace

echo ==========================================
echo
echo === Building [canvas-objects.js]
echo ...

	# Explicitely declare the global ctk object.
	echo	'var ctk = {};'					> canvas-objects.js
	
	# Concatenate the source files.
	cat		ctk/util/AreaMap.js				>> canvas-objects.js
	cat		ctk/util/Canvas.js				>> canvas-objects.js
	cat		ctk/util/ProcessLoop.js			>> canvas-objects.js
	cat		ctk/draw/Draw.js				>> canvas-objects.js
	cat		ctk/draw/Rect.js				>> canvas-objects.js
	cat		ctk/draw/Border.js				>> canvas-objects.js
	cat		ctk/draw/Style.js				>> canvas-objects.js
	cat		ctk/draw/Item.js				>> canvas-objects.js
	
	# Remove the line which declares the global ctk object.
	sed -i -e "/ global ctk /d"		canvas-objects.js

echo ...
echo === Building succeeded. Wrote to [canvas-objects.js]
echo
echo ==========================================
echo
echo === Documenting [canvas-objects.js]
echo === Clearing output [docs/]
rm -fdr docs
echo ...

	jsdoc \
		--configure build/jsdoc.json	\
		canvas-objects.js				\

echo ...
echo === Documentation succeeded. Wrote to [docs/]
echo
echo ==========================================
echo
echo === Compiling [canvas-objects.min.js]
ls -l canvas-objects.min.js
echo === Clearing output [canvas-objects.min.js]
rm -f canvas-objects.min.js
echo ...

	java -jar node_modules/google-closure-compiler/compiler.jar \
			--js										\
				canvas-objects.js						\
			--js_output_file							\
				canvas-objects.min.js					\
			--externs									\
				"build/closure-compiler-externs.js"		\
			--compilation_level SIMPLE					\
			# --compilation_level ADVANCED				\
			# --warning_level VERBOSE					\
			# --process_common_js_modules				\

echo ...
ls -l canvas-objects.min.js
echo === Compilation succeeded. Wrote to [canvas-objects.min.js]
echo
echo ==========================================

echo --- END OF BUILD ---
