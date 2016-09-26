'use strict';

var gulp = require('gulp');

// CSS-related plugins
var sass         = require('gulp-sass');
var autoprefixer = require('gulp-autoprefixer');
var cssnano      = require('gulp-cssnano');

// Utility plugins
var browserSync = require('browser-sync').create();

// Paths
var paths = {
  stylesheetSrc:  './source/stylesheets/app.scss', // Path to the main .scss file
  stylesheetDest: './.tmp/stylesheets', // Path to the main compiled .css file

  watchStylesheets: './source/stylesheets/**/*.scss', // Path to all .scss files
  watchTemplates:   './source/**/*.erb' // Path to all .erb files
};

gulp.task('serve', function () {
  browserSync.init({
    proxy:       'localhost:4567',
    reloadDelay: 2000
  });
});

gulp.task('stylesheets', function () {
  gulp.src(paths.stylesheetSrc)
      .pipe(sass({
        includePaths: ['./bower_components'],
        outputStyle:  'expanded'
      }))
      .pipe(autoprefixer({
        browsers: ['last 2 versions'],
        cascade:  false
      }))
      .pipe(cssnano())
      .pipe(gulp.dest(paths.stylesheetDest))
      .pipe(browserSync.stream({ match: '**/*.css' }));
});

gulp.task('watch', ['stylesheets', 'serve'], function () {
  gulp.watch(paths.watchStylesheets, ['stylesheets']);
  gulp.watch(paths.watchTemplates).on('change', browserSync.reload);
});

gulp.task('default', ['stylesheets']);
