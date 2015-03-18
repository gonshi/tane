module.exports = {
  js: {
    files: [{
      expand: true,
      cwd: '<%= config.dir.src %>/js',
      src:['**/*.js'],
      dest: '<%= config.dir.tmp %>/js'
    }]
  },
  jsProd: {
    files: [{
      expand: true,
      cwd: '<%= config.dir.src %>/js/',
      src:['**/*.js'],
      dest: '<%= config.dir.dist %>/js/'
    }]
  },
  font: {
    files: [{
      expand: true,
      cwd: '<%= config.dir.src %>/font',
      src:['**/*'],
      dest: '<%= config.dir.tmp %>/font'
    }]
  },
  fontProd: {
    files: [{
      expand: true,
      cwd: '<%= config.dir.src %>/font',
      src:['**/*'],
      dest: '<%= config.dir.dist %>/font'
    }]
  },
  img: {
    files: [{
      expand: true,
      cwd: '<%= config.dir.src %>/img',
      src:['**/*'],
      dest: '<%= config.dir.tmp %>/img'
    }]
  },
  imgProd: {
    files: [{
      expand: true,
      cwd: '<%= config.dir.src %>/img',
      src:['**/*'],
      dest: '<%= config.dir.dist %>/img'
    }]
  }
};
