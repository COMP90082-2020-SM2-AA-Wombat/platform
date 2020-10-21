c = get_config()

c.JupyterHub.spawner_class = 'repo2dockerspawner.Repo2DockerSpawner' #see https://github.com/ideonate/repo2dockerspawner

# default images
c.Repo2DockerSpawner.build_image = 'jupyter/repo2docker:0.11.0'
c.DockerSpawner.image = 'jupyter/scipy-notebook'
c.DockerSpawner.network_name = 'jupyterhub_network'
c.JupyterHub.hub_ip = '0.0.0.0' 
c.DockerSpawner.use_internal_ip = True
c.JupyterHub.hub_connect_ip = 'jupyterhub' #hub container name
c.Authenticator.admin_users = {'admin'} #admin user still needs to be created on start up but does not need to be authorized
c.DockerSpawner.start_timeout = 600
c.JupyterHub.authenticator_class = 'nativeauthenticator.NativeAuthenticator' #hub/authorize when logged in as admin will allow you to authorize the creation of new users.
                                                                                #See https://native-authenticator.readthedocs.io/en/latest/quickstart.html
c.DockerSpawner.remove_containers = True #containers are deleted when stopped
c.Spawner.default_url = '/lab' #use jupyterlab

'''
TO-DO: 
    - Limit user access to certain dirs in repo
    - pull from private git repo
    - allow for easier push to origin and merging to main in repo from jupyter console
    - spwan spawners on user's host machine
    - export notebooks from jupyter console
'''