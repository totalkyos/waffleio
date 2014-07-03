module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['clean', 'coffee']

  grunt.registerTask 'test', ['mochaTest']

  grunt.initConfig

    clean: ['dist']

    watch:
      src:
        files: 'src/**/*.coffee'
        tasks: ['coffee:src']

    coffee:
      src:
        expand: true
        cwd: 'src/'
        src: ['**/*.coffee']
        dest: 'dist'
        ext: '.js'

    mochaTest:
      test:
        options:
          reporter: 'dot'
          require: [
            'coffee-script/register'
          ]
        src: ['spec/**/*.coffee']
