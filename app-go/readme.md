# Go Lang Example

### Step-1 Build Your Environment
Go to main readme.md file and follow the steps in [Build Your Environment](../readme.md) and Execute `docker_up` command.
Following steps command must be executed within the container.

Note:
- The install directory is controlled by the GOPATH and GOBIN environment variables.
- If GOBIN is set, binaries are installed to that directory.
- If GOPATH is set, binaries are installed to the bin subdirectory of the first directory in the GOPATH list.
- Otherwise, binaries are installed to the bin subdirectory of the default GOPATH ($HOME/go or %USERPROFILE%\go).
- You can use the go env command to portably set the default value for an environment variable for future go commands: `go env -w GOBIN=/somewhere/else/bin`
- To unset a variable previously set by go env -w, use go env -u: `go env -u GOBIN`


### Step-2 Create Directory and Set Path
```
$ mkdir -p /app/app-go/src

# we should set GOPATH in such a way that when we go inside the GOPATH we should able to see src directory
export GOPATH=/app/app-go

# When go is run with a user with unknown home (as it could be the case while using cri-o),
# go will default $HOME to / which causes issues while creating $HOME/.cache directory as go
# test or go list do.
# The workaround:
# GOCACHE=off
# or
# GOCACHE=/tmp/
export GOCACHE=/tmp/

$ cd /app/app-go/src
```

### Step-2 Create Sample Application
This step require only one time when we are creating application from scratch
```
$ cd /app/app-go/src
$ go mod init example/user/hello
# go: creating new go.mod: module example/user/hello

$ cat go.mod
# it will show similar to following
  module example/user/hello

  go 1.16
```

### Step-2 Installing Sample Application
```
$ cd /app/app-go/src
# The go mod tidy command adds missing module requirements for imported packages and removes requirements on modules
# that aren't used anymore, it will download dependencies in $GOPATH/pkg folder
$ go mod tidy

# Importing packages from your module
$ cd /app/app-go/src/morestrings

# This won't produce an output file. Instead it saves the compiled package in the local build cache.
$ go build

# This command builds the hello command, producing an executable binary. It then installs that binary as
# $GOPATH/bin/hello (or, under Windows, %$GOPATH%\bin\hello.exe).
$ go install example/user/hello
$ $GOPATH/bin/hello
```


## Resources
1. [How to Write Go Code](https://go.dev/doc/code)
