## Gocrypt Im Forward-Modus (Dateien sind verschlüsselt und werden beim Mounten entschlüsselt)
Im Forward-Modus werden die Daten verschlüsselt gespeichert, der entschlüsselte Lese- und Schreibzugriff erfolgt über das lokal FUSE-Dateisystem. 
Dieser Betriebsmodus könnte beispielsweise eingesetzt werden, um die Daten in der Cloud verschlüsselt zu speichern.
(Dropbox bekommt die entschlüsselte Datei nie zu sehen)

Beispiel:

/home/masch/plain
/home/masch/Dropbox/crypt

```
apt install gocryptfs 
mkdir /home/masch/plain 
mkdir /home/masch/Dropbox/crypt
gocryptfs --version
gocryptfs -init /home/masch/Dropbox/crypt
gocryptfs /home/masch/Dropbox/crypt /home/masch/plain 
cd /home/masch/plain 
touch test.txt
umount /home/masch/plain
```
Passwort ändern
gocryptfs -config ~/.config/gocryptfs/KONFDATEI.conf -passwd /home/masch/plain 

Mit Materkey, falls Passwort unbekannt
gocryptfs -masterkey=xxxxxxxx-xxxxxxxx-xxxxxxxx-xxxxxxxx-xxxxxxxx-xxxxxxxx-xxxxxxxx-xxxxxxxx /home/masch/Dropbox/crypt /home/masch/plain 



## Gocrypt Im Reverse-Modus (Dateien sind entschlüsselt und werden beim Mounten verschlüsselt)

Im Reverse-Modus wird der Inhalt von /home/masch/plain über das FUSE-Dateisystem bei /home/masch/Dropbox/crypt „read-only“ angezeigt, wenn dieses eingehängt ist. So kann beispielsweise ein verschlüsseltes Backup angelegt werden, ohne weiteren Platzbedarf. 
```
mkdir /home/masch/plain 
mkdir /home/masch/Dropbox/crypt
gocryptfs -init -reverse /home/masch/plain
gocryptfs -reverse /home/masch/plain /home/masch/Dropbox/crypt
touch /home/masch/text.txt
scp -r /home/masch/Dropbox/crypt remote_username@10.10.0.2:/backup_von_masch_plain
umount /home/masch/Dropbox/crypt
```
