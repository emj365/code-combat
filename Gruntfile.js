module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({

    pkg: grunt.file.readJSON('package.json'),

    watch: {
      scripts: {
        files: ['src/**/**/*.coffee'],
        tasks: ['coffee:compile'],
        options: {
          spawn: false,
        },
      },
    },

    coffee: {
      compile: {
        files: {
          'build/sky-span_ogres_commander.js': [
            'src/sky-span/ogres/options.coffee',
            'src/sky-span/ogres/common.coffee',
            'src/sky-span/ogres/commander.coffee'
          ],
          'build/sky-span_ogres_shaman.js': [
            'src/sky-span/ogres/options.coffee',
            'src/sky-span/ogres/common.coffee',
            'src/sky-span/ogres/shaman.coffee'
          ],
        },
      },
    },

  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-coffee');

  // Default task(s).
  grunt.registerTask('default', ['watch']);

};
