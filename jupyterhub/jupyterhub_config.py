import os

c = get_config()

# ----Jupyter Hub Configs-------

# launch with docker
c.JupyterHub.spawner_class = 'dockerspawner.DockerSpawner'

# we need the hub to listen on all ips when it is in a container
c.JupyterHub.hub_ip = '0.0.0.0'

# the hostname/ip that should be used to connect to the hub
# this is usually the hub container's name
c.JupyterHub.hub_connect_ip = 'jupyterhub'

c.JupyterHub.authenticator_class = 'nativeauthenticator.NativeAuthenticator' #hub/authorize when logged in as admin will allow you to authorize the creation of new users.

c.JupyterHub.admin_access = True
                                                                                #See https://native-authenticator.readthedocs.io/en/latest/quickstart.html
# ----Docker Spawner Configs-------

# The network for spawned containers
c.DockerSpawner.network_name = 'jupyterhub_network'

# Docker image for spawned containers
c.DockerSpawner.image = 'custom-lab'

# Admin users for spawned containers. NB: these users must still be created in the hub, but dont require authorization.
c.Authenticator.admin_users = {'admin'} 

# Default directory when logging into a spawned lab
notebook_dir = '/home/jovyan/work'
c.DockerSpawner.notebook_dir = notebook_dir

# Mount the real user's Docker volume on the host to the notebook user's notebook directory in the container
c.DockerSpawner.volumes = { 'jupyterhub-user-{username}': notebook_dir }

# Spawned containers are deleted when stopped but voumes will remain on host
c.DockerSpawner.remove_containers = True 

# JupyterLab to be used rather than Notebooks.
c.Spawner.default_url = '/lab' #use jupyterlab

'''
TO-DO: 
    - Limit user access to certain dirs in repo
    - spwan spawners on user's host machine
    - export notebooks from jupyter console
    - allow for input as to what image to be spawned
'''