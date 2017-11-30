


module.exports = {
  apps: [{
    name: '121policy',
    script: './src/index.js'
  }],
  deploy: {
    production: {
      user: 'ec2-user',
      host: 'ec2-13-126-33-185.ap-south-1.compute.amazonaws.com',
      key: '121policy_backup_mumbai.pem',
      ref: 'origin/master',
      "post-setup": "ls -la",
      "pre-deploy-local" : "echo 'This is a local executed command'",
      //repo: 'https://github.com/Manishjha1991/api-express-boilerplate.git',
      repo:'git@github.com:Manishjha1991/api-express-boilerplate.git',
      "ssh_options": ["StrictHostKeyChecking=no", "PasswordAuthentication=no"],
      path:'/home/ec2-user/api-express-boilerplate', 
      'post-deploy': 'npm install && pm2 startOrRestart ecosystem.config.js'
    }
  }
}