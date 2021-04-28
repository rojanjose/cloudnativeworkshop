# Helm v3

Refer to the [Helm install docs](https://helm.sh/docs/intro/install/) for more details.

To install Helm v3, run the following commands,

1. In the `Cloud Shell`, download and unzip Helm v3.2.

    ```console
    cd $HOME
    wget https://get.helm.sh/helm-v3.2.0-linux-amd64.tar.gz
    tar -zxvf helm-v3.2.0-linux-amd64.tar.gz
    ```

2. Make Helm v3 CLI available in your `PATH` environment variable.

    ```console
    echo 'export PATH=$HOME/linux-amd64:$PATH' > $HOME/.bash_profile
    source $HOME/.bash_profile
    ```

3. Verify Helm v3 installation.

    ```console
    helm version --short
    ```

    outputs,

    ```console
    $ helm version --short
    v3.2.0+ge11b7ce
    ```
