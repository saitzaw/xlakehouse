## install unity catalog 
- install java 17 openJDK
```
sudo apt install openjdk-17-jdk openjdk-17-jre
```

## Choose default java 
- to switch multiple java version 
``` 
sudo update-alternatives --config java
```
## get UC from git 
```
git clone git@github.com:unitycatalog/unitycatalog.git
```

## clean the cache created by old cs  
```
sudo rm -r ~/.cache
```

## update the sbt 
```
sbt update 
```

## reload the sbt 
```
sbt reload 
```

## build the package 
- go to the unitycatalog directory 
```
cd $HOME/unitycatalog
./build/sbt package
```
## run the UC 
```
./bin/start-uc-server
```

## Install node  
- Nodejs 
```
curl -fsSL https://fnm.vercel.app/install | bash
```

## Install 
- install yarn 
```
npm install --global yarn
```

## Run the UI 
```
yarn start
```
