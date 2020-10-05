import os

c = get_config()

c.JupyterHub.spawner_class = "dockerspawner.DockerSpawner"
c.DockerSpawner.image = os.environ["DOCKER_JUPYTER_IMAGE"]
c.DockerSpawner.network_name = os.environ["DOCKER_NETWORK_NAME"]
c.JupyterHub.hub_ip = os.environ["HUB_IP"]
c.Authenticator.admin_users = {'admin'}

c.JupyterHub.authenticator_class = 'nativeauthenticator.NativeAuthenticator'

notebook_dir = os.environ.get('DOCKER_NOTEBOOK_DIR') or '/home/notebooks/personal'
c.DockerSpawner.notebook_dir = notebook_dir

# Mount the real user's Docker volume on the host to the notebook user's
# notebook directory in the container
c.DockerSpawner.volumes = {
          'jupyterhub-user-{username}': notebook_dir,
          'jupyterhub-shared': '/home/notebooks/shared',
          'jupyterhub-data': '/home/notebooks/data'
}

c.DockerSpawner.remove_containers = True
c.Spawner.default_url = '/lab'