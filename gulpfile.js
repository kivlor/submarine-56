// require require require
var gulp = require('gulp'),
	plumber = require('gulp-plumber'),
	rename = require('gulp-rename'),
	notify = require('gulp-notify'),
	livereload = require('gulp-livereload'),

	sass = require('gulp-ruby-sass'),
	autoprefixer = require('gulp-autoprefixer'),
	minifycss = require('gulp-minify-css'),

	coffee = require('gulp-coffee'),
	jshint = require('gulp-jshint'),
	uglify = require('gulp-uglify'),

	onError = function(err) { console.log(err) }

gulp.task('styles', function() {
	return gulp.src('assets/scss/*.scss')
		.pipe(plumber({errorHandler: onError}))
		.pipe(sass({ style: 'expanded' }))
		.pipe(autoprefixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1'))
		.pipe(rename({suffix: '.min'}))
		.pipe(minifycss())
		.pipe(gulp.dest('public/styles'));
});

gulp.task('scripts', function(){
	return gulp.src('assets/coffee/*.coffee')
		.pipe(plumber({errorHandler: onError}))
		.pipe(coffee({bare: true}))
		//.pipe(gulp.dest('public/scripts'))
		.pipe(uglify())
		.pipe(rename({suffix: '.min'}))
		.pipe(gulp.dest('public/scripts'));
});

gulp.task('watch', function() {
	livereload.listen();

	gulp.watch('assets/scss/**/*.scss', ['styles']);
	gulp.watch('assets/coffee/**/*.coffee', ['scripts']);

	gulp.watch(['public/**', 'app/views/**']).on('change', livereload.changed);
});

gulp.task('build', function(){
	gulp.start('styles', 'scripts');
});

gulp.task('default', ['watch']);