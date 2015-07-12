var gulp = require('gulp');
var sass = require('gulp-sass');
var autoprefixer = require('gulp-autoprefixer');

var paths = {
  sass: './static/scss/**/*.scss',
  css: './static/css/'
};

gulp.task('sass', function () {
  gulp.src(paths.sass)
    .pipe(sass().on('error', sass.logError))
    .pipe(autoprefixer())
    .pipe(gulp.dest(paths.css));
});

gulp.task('sass:watch', function () {
  gulp.watch(paths.sass, ['sass']);
});

gulp.task('default', ['sass:watch']);
