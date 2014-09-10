hadoop Cookbook
===============
Chef cookbook which installs [Hadoop](http://hadoop.apache.org/)

Hadoop core components
----------------------
Hadoop contains two main components **HDFS** (storage) and **MapReduce** (processing)

### HFDS
HDFS (Hadoop Distributed File System) is a distributed file system that provides high-throughput access to data.

#### Main components:
- `NameNode` is the master of the system. It maintains the name system (directories and files) and manages the blocks which are present on the DataNodes.
- `DataNodes` are the slaves which are deployed on each machine and provide the actual storage. They are responsible for serving read and write requests for the clients.
- `Secondary NameNode` is responsible for performing periodic checkpoints. In the event of NameNode failure, you can restart the NameNode using the checkpoint.

### YARN
The fundamental idea of YARN is to split up the two major responsibilities of the MapReduce - JobTracker i.e. resource management and job scheduling/monitoring, into separate daemons: a global ResourceManager and per-application ApplicationMaster (AM).

#### Main components:
- `ResourceManager`(YARN) / `JobTracker`(MRv1) is the master of the system which manages the jobs and resources in the cluster (TaskTrackers). The JobTracker tries to schedule each map as close to the actual data being processed i.e. on the TaskTracker which is running on the same DataNode as the underlying block.
- `NodeManager`(YARN) / `TaskTracker`(MRv1) are the slaves which are deployed on each machine. They are responsible for running the map and reduce tasks as instructed by the JobTracker.
- `JobHistoryServer` is a daemon that serves historical information about completed applications. Typically, JobHistory server can be co-deployed with Job­Tracker, but we recommend to run it as a separate daemon.

### MapReduce
MapReduce aka. MRv1 (old) and MRv2 (new) is a framework for performing distributed data processing using the MapReduce programming paradigm.

#### Main components:
- `ApplicationMaster` The per-application ApplicationMaster is, in effect, a framework specific entity and is tasked with negotiating resources from the ResourceManager and working with the NodeManager(s) to execute and monitor the component tasks.

Cookbook requirements
------------

#### packages
- `ark` - Ark cookbook to download and unpack Hadoop package
#### For development
- Ruby
- Bundler [bundler.io](http://bundler.io)
- Required gems `bundle install`
- Required cookbooks `berks install --path .berkshelf`
- Vagrant [vagrantup.com](http://vagrantup.com)

Attributes
----------

#### hadoop
| Key | Type | Description | Default | 
| --- | ---- | ----------- | ------- |
| ['hadoop']['version'] | String | Target Hadoop version | 2.4.0 |
| ['hadoop']['mirror'] | String | Mirror for Hadoop | http://www.nic.funet.fi/pub/mirrors/apache.org/hadoop/common/ | 
| [:hadoop][:user] | String | User name for hadoop. |'hadoop' |
| [:hadoop][:group] | String | Group for hadoop. |'hadoop' |
| [:hadoop][:supergroup] | String | Name of super group allowed to use hadoop. |'hadoop' |
| [:hadoop][:users] | String | Users to add to hadoop supergroup. | {}|
| [:hadoop][:install_dir] | String | Hadoop installation directory. |'/usr/local' |
| [:hadoop][:tmp_dir] | String | Hadoop temp directory. |'/opt/hadoop/tmp' |
| [:hadoop][:namenode][:host] | String | Host to run namenode. |'localhost' |
| [:hadoop][:namenode][:port] | String | Port for namenode. |'54310' |
| [:hadoop][:tracker] | String | Host for jobtracker. |'localhost:54311' |
| [:hadoop][:resourcemanager][:host] | String | Host for resourcemanager. |'localhost' |
| [:hadoop][:webhdfs] | String | Is webhdfs enabled or not |false |
| [:hadoop][:permissions] | String | Check permissions | true |
| [:hadoop][:permitted_hosts] | String | Allowed hosts | "" |
| [:hadoop][:ip_hostname_check] | String | Check if hostname is in permitted hosts list. |true |
| [:hadoop][:rpc_bind_host] | String | The actual address the server will bind to. | nil |
| [:hadoop][:datanode][:data_dir] | String | Directory to store datanodes data |'/opt/hadoop/tmp/datanode' |
| [:hadoop][:namenode][:name_dir] | String | Directory to store namenodes data | '/opt/hadoop/tmp/namenode' |
| [:hadoop][:nodemanager][:address] | String | Address to run nodenamanger |'0.0.0.0:0' |
| [:hadoop][:core_configs] | String | Additional core configs to add | {} |

Usage
-----
Just include `hadoop` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[hadoop]"
  ]
}
```

Development
----------
To develop this cookbook you have following tools to help your development:

* [Guard](https://github.com/guard/guard) - Automatically run tests and executes style validations
* [Tailor](https://github.com/turboladen/tailor) - Validates Ruby code style
* [ChefSpecs](https://github.com/acrmp/chefspec) - Unit test cookbooks
* [Foodcritic](http://acrmp.github.io/foodcritic/) - Validates cookbook style
* [Kitchen](https://github.com/opscode/test-kitchen) - Run cookbook inside virtual machine(s)
* [minitests](https://github.com/calavera/minitest-chef-handler) - Run integration tests target machine

#### Install required gems and cookbooks
To be able to develop you need couple gems and cookbooks. First install Bundler [bundler.io](http://bundler.io). Then:
```
bundle install
berks install --path .berkshelf
```

**And you're ready to start!**

#### Run tests with Test-Kitchen
Project contains [Test-Kitchen](http://kitchen.ci/) setup to easily test cookbook.
Test-Kitchen runs the tests in Docker container.

To run Test-Kitchen:
1. Install [Docker](docker.io)
2. Run `kitchen test`

>Note: You might need to create following file in root of this folder:

```yml
# File: kitchen.local.yml
---
driver:
  name: docker
  binary: docker
  socket: <%= ENV['DOCKER_HOST'] %>
```

#### Auto-run tests
While you develop cookbook you should use [Guard](https://github.com/guard/guard) to run tests every time you change any file. It also run code and cookbook styles and tell you if you don't follow common coding styles.

To run Guard, simple open new terminal window

```
guard
```

#### Run ChefSpecs
To unit tests cookbooks we use [ChefSpecs](https://github.com/acrmp/chefspec). Tests doesn't test end state, it only asserts that recipe contains all required resources, execute right scripts and so on.

To run ChefSpecs:
```
rspec spec
```

***Note: The Guard will run these tests for you automatically so you don't have to run them manually***

#### Run

#### Vagrantbox

Vagrant box contains all components of Hadoop.
Startup vagrant box
```
vagrant up
```

After it is started, you should be able to access:

- HDFS infomation [http://192.168.60.101:50070/](http://192.168.60.101:50070/)
- MapReduce information [http://192.168.60.101:8088/cluster](http://192.168.60.101:8088/cluster)

To access server trough SSH

# Login to master server

```Bash
vagrant ssh master
```

# Login to slave server

```Bash
vagrant ssh slave
```



Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: [Erno Aapa](https://github.com/eaapa), Kimi Ylilammi, Hung Ta