coffee			= require "gulp-coffee"
gulp				= require "gulp"
bump				= require "gulp-bump"
git					= require "gulp-git"
gutil				= require "gulp-util"
rename			= require "gulp-rename"
plumber			= require "gulp-plumber"
uglify			= require "gulp-uglify"
watch				= require "gulp-watch"
browserSync = require "browser-sync"
reload			= browserSync.reload
spawn				= require('child_process').spawn





#*------------------------------------*\
##	 $BROWSER SYNC
#*------------------------------------*/
gulp.task 'auto-reload', () ->
	process = undefined

	restart = () ->
		if process
			process.kill()
		process = spawn('gulp', [ 'default' ], stdio: 'inherit')
		return

	gulp.watch ['gulpfile.coffee', 'config.js'], restart
	restart()
	return

gulp.task "browser-sync", () ->
	browserSync {
		injectChanges: true
		# tunnel: true
		open: false
		server:
			baseDir: './'
	}





#*------------------------------------*\
##	 $BUMP
#*------------------------------------*/
gulp.task 'bump:major', (ver) ->
	gulp.src 'package.json'
		.pipe bump({type: 'major'})
		.pipe gulp.dest './'
		.pipe git.commit('bump version')

gulp.task 'bump:minor', (ver) ->
	gulp.src 'package.json'
		.pipe bump({type: 'minor'})
		.pipe gulp.dest './'
		.pipe git.commit('bump version')

gulp.task 'bump', (ver) ->
	gulp.src 'package.json'
		.pipe bump({type: 'patch'})
		.pipe gulp.dest './'
		.pipe git.commit('bump version')





#*------------------------------------*\
##	 $HTML
#*------------------------------------*/
gulp.task "html", () ->
	gulp.src ["*.html"]
		.pipe reload({stream: true})





#*------------------------------------*\
##	 $COFFEE
#*------------------------------------*/
gulp.task "coffee", () ->
	gulp.src ["src/*.coffee"]
		.pipe plumber()
		.pipe coffee({bare: true})
		.pipe gulp.dest("dist")





#*------------------------------------*\
##	 $UGLIFY
#*------------------------------------*/
gulp.task "uglify", () ->
	gulp.src ["dist/*.js", "!dist/*.min.js"]
		.pipe uglify()
		.pipe rename({ suffix: '.min' })
		.pipe gulp.dest("dist/")





#*------------------------------------*\
#		$WATCH
#*------------------------------------*/
gulp.task "watch", () ->
	gulp.watch "src/*.coffee", ["coffee", "uglify", reload]
	gulp.watch "demo/*.html", ["html"]





#*------------------------------------*\
##	 $DEFAULT
#*------------------------------------*/
gulp.task "default", [
	"coffee"
], () ->
	gulp.start "browser-sync", "watch"
	return

