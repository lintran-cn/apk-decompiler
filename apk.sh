# shell脚本目录
shell_dir=$(
   cd $(dirname $0)
   pwd
)

# apk路径
apk_path=$1

if [ "${apk_path##*.}"x = "apk"x ]; then
   tmp=${apk_path##*/}
   # 输出目录
   out_put_dir=${tmp%.*}
   # apk父目录
   root_dir=$(dirname $apk_path)
else
   echo "Error : 输入apk文件地址"
fi

dex2jar_fun() {
   cc=$(dirname $1)
   aa=${1##*/}
   # 输出目录
   bb=${aa%.*}

   sh $shell_dir/dex-tools-2.1/d2j-dex2jar.sh $1 -o $cc"/"jars/$bb-dex2jar.jar  --force
}

##递归遍历
traverse_dir() {
   for i in $(ls -a $1); do
      if [[ $i =~ .*\.dex$ ]]; then
         lsfile=$1"/"$i
         eval $2 $lsfile
      fi
   done
}

function read_dir() {
   rm -rf $root_dir"/"$out_put_dir

   echo "do_apktool"
   sh $shell_dir/apktool.sh d -s -f $apk_path -o $root_dir"/"$out_put_dir

   echo "do_dex2jar"
   traverse_dir $root_dir"/"$out_put_dir dex2jar_fun
   # sh $shell_dir/dex-tools-2.1/d2j-dex2jar.sh  $rootDir"/"$file"/"classes.dex -o $rootDir"/"$file"/"jars/classes-dex2jar.jar  --force

   echo "do_JD_GUI"
   open -a $shell_dir/jd-gui-osx-1.6.6/JD-GUI.app/ $root_dir"/"$out_put_dir"/"jars/classes-dex2jar.jar

   echo "success out:" $root_dir"/"$out_put_dir
}

#读取第一个参数
read_dir
