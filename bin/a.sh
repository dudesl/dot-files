
out=`nc 127.0.0.1 11211 << EOF
stats items
quit
EOF`
echo $out | tr -cd '\11\12\40-\176'| sed s/STAT/\\n/g | sed s/END//g> tempo1.log
echo "guardo en $PWD/tempo1.log"

echo "out=\`nc 127.0.0.1 11211 << EOF" > tempo2.log
#cat tempo1.log | sed "s/items:\([0-9]*\):.* /stats cachedump \1 1000/g" | sort -u >> tempo2.log
cat tempo1.log |  sed "s/items:\([0-9]*\):.* /stats cachedump \1 1000/g" | sort -u  >> tempo2.log
echo "quit" >> tempo2.log
echo "EOF\`" >> tempo2.log
echo "echo \$out" >> tempo2.log
echo "guardo en $PWD/tempo2.log"

sh tempo2.log > tempo3.log
echo "guardo en $PWD/tempo3.log"

grep "paymentMethods\|payerCost" tempo3.log > tempo4.log
#grep "paymentMethods\|payerCost\|Request" tempo3.log > tempo4.log
echo "guardo en $PWD/tempo4.log"

cat tempo4.log | sed "s/ITEM/\\nITEM/g" | sed "s/.*ITEM \(.*\)\[.*/sh \/department\/wrapper\/bin\/remove_key_memcached.sh \1/" > tempo5.log
echo "guardo en $PWD/tempo5.log"



grep "paymentMethods\|payerCost" tempo5.log > tempo6.log
echo "guardo en $PWD/tempo6.log"

echo "terminado, falta correr: sh $PWD/tempo5.log"

