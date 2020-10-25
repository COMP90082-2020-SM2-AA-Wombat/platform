c = get_config()

# launch with docker

c.JupyterHub.spawner_class = 'dockerspawner.DockerSpawner'

# we need the hub to listen on all ips when it is in a container
c.JupyterHub.hub_ip = '0.0.0.0'

# the hostname/ip that should be used to connect to the hub
# this is usually the hub container's name
c.JupyterHub.hub_connect_ip = 'jupyterhub'

# pick a docker image. This should have the same version of jupyterhub
# in it as our Hub.
c.DockerSpawner.image = 'jupyter/customm-lab'

c.DockerSpawner.network_name = 'jupyterhub_network'

# c.DockerSpawner.use_internal_ip = True
c.Authenticator.admin_users = {'admin'} #admin user still needs to be created on start up but does not need to be authorized

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