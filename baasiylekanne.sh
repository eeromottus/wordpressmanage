
fromssh="virt1111@domeen1.ee"
from_wp_path="domeenid/www.domeen1.ee/htdocs"
tossh="virt2222@domeen2.ee"
to_wp_path="domeenid/www.domeen2.ee/test"
prefixfrom="from"

myArray=("DB_HOST" "DB_USER" "DB_PASSWORD" "DB_NAME") 
FROM_OPTIOS=("siteurl" "home")

for file in ${myArray[@]}; do
  eval "from_${file}=$(ssh $fromssh "cd $from_wp_path; wp config get --constant=$file")"
done
#echo "${from_DB_HOST}"

for file in ${WP_OPTIONS[@]}; do
  eval "from_options_${file}=$(ssh $fromssh "cd $from_wp_path; wp option get $file")"
done
echo "${from_options_siteurl}"

for file in ${WP_OPTIONS[@]}; do
  eval "to_options_${file}=$(ssh $tossh "cd $to_wp_path; wp option get $file")"
done
echo "${to_options_siteurl}"

for file in ${myArray[@]}; do
  eval "to_${file}=$(ssh $tossh "cd $to_wp_path; wp config get --constant=$file")"
  eval "echo to_${file}=\${to_${file}}"
done
#echo "${to_DB_HOST}"

#ssh $tossh  "mysql -h $to_DB_HOST -u $to_DB_USER -p"$to_DB_PASSWORD" -e 'drop database $to_DB_NAME'"
#ssh $tossh  "mysql -h $to_DB_HOST -u $to_DB_USER -p"$to_DB_PASSWORD" -e 'create database $to_DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci'"
#ssh $fromssh "mysqldump -h ${from_DB_HOST} -u ${from_DB_USER} -p"$from_DB_PASSWORD" ${from_DB_NAME}" | ssh $tossh  "mysql --default-character-set=utf8 -h ${to_DB_HOST} -u ${to_DB_USER} -p${to_DB_PASSWORD} ${to_DB_NAME}" 

ssh $tossh "rm -Rf $to_wp_path; mkdir -p $to_wp_path"
ssh $fromssh "tar zcf - -C ${from_wp_path} ." | ssh $tossh "tar zxf - -C ${to_wp_path}"

for file in ${myArray[@]}; do
  FROM_FILE_OUTPUT=$(eval "echo \$from_${file}")
  TO_FILE_OUTPUT=$(eval "echo \$to_${file}")	
  old_text="define('$file', '$FROM_FILE_OUTPUT');"
  new_text="define('$file', '$TO_FILE_OUTPUT');"
  ssh $tossh "cd ${to_wp_path}; sed -i \"/${old_text}/c\\${new_text}\" wp-config.php"
  #echo "${old_text}"
  #echo "${new_text}"
done

for file in ${WP_OPTIONS[@]}; do
  ssh $tossh "cd $to_wp_path; wp option update $file ${to_options_siteurl}"
done

ssh $tossh "cd $to_wp_path; wp search-replace ${from_options_siteurl} ${to_options_siteurl} --all-tables"
