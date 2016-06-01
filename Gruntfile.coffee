module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['clean', 'coffee']

  grunt.registerTask 'test', ['mochaTest']

  grunt.initConfig

    bump:
      options:
        commitFiles: ['-a']
        files: ['package.json']
        prereleaseName: 'alpha'
        pushTo: 'origin'

    clean: ['dist', 'lib']

    coffee:
      src:
        expand: true
        cwd: 'src/'
        src: ['**/*.coffee']
        dest: 'lib'
        ext: '.js'

    mochaTest:
      test:
        options:
          reporter: 'dot'
          require: [
            'coffee-script/register'
          ]
        src: ['spec/**/*.coffee']

    watch:
      src:
        files: 'src/**/*.coffee'
        tasks: ['coffee:src']
      test:
        files: [
          'src/**/*.coffee'
          'spec/**/*.coffee'
        ]
        tasks: ['mochaTest']
