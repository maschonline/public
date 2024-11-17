Eine WireGuard-Konfigurationsdatei besteht aus einem Server- und/oder Client-Block und enthält die notwendigen Einstellungen für die Verbindung. Hier ist ein einfaches Beispiel für eine Server- und Client-Konfigurationsdatei.

### 1. Server-Konfiguration (`wg0.conf`)

```ini
[Interface]
# Server Interface
Address = 10.0.0.1/24           # IP-Adresse des Servers im VPN-Netzwerk
ListenPort = 51820               # Port, auf dem der Server lauscht
PrivateKey = <SERVER_PRIVATE_KEY>  # Der private Schlüssel des Servers

[Peer]
# Beispiel für einen Client
PublicKey = <CLIENT_PUBLIC_KEY>   # Der öffentliche Schlüssel des Clients
AllowedIPs = 10.0.0.2/32          # IP-Adresse des Clients im VPN-Netzwerk
```

### 2. Client-Konfiguration (`wg0.conf`)

```ini
[Interface]
# Client Interface
Address = 10.0.0.2/24           # IP-Adresse des Clients im VPN-Netzwerk
PrivateKey = <CLIENT_PRIVATE_KEY> # Der private Schlüssel des Clients

[Peer]
# Server
PublicKey = <SERVER_PUBLIC_KEY>   # Der öffentliche Schlüssel des Servers
Endpoint = server-ip-or-domain:51820  # IP-Adresse oder Domain des Servers mit Port
AllowedIPs = 0.0.0.0/0            # Der Client routet alles über das VPN
PersistentKeepalive = 25          # Verhindert, dass die Verbindung bei Inaktivität getrennt wird
```

### Erklärungen:

- **PrivateKey** und **PublicKey**: Jedes Gerät in einem WireGuard-Netzwerk muss ein Schlüsselpaar (privat und öffentlich) haben. Die privaten Schlüssel sollten sicher aufbewahrt werden, während die öffentlichen Schlüssel zwischen den Peers (Server und Client) ausgetauscht werden.
  
- **Address**: Gibt die IP-Adresse an, die dem Interface zugewiesen wird. Diese sollte im selben Subnetz wie das VPN-Netzwerk liegen.

- **AllowedIPs**: Definiert, welche IP-Adressen über das VPN geroutet werden. Beim Server gibt man die IP-Adresse des Clients an, beim Client z.B. `0.0.0.0/0`, um den gesamten Internetverkehr über das VPN zu leiten.

- **ListenPort**: Der Port, auf dem der WireGuard-Server auf eingehende Verbindungen wartet.

- **Endpoint**: Gibt den Server an, mit dem sich der Client verbinden soll. Der Endpoint besteht aus der IP-Adresse des Servers und dem Port, der in der Serverkonfiguration angegeben ist.

- **PersistentKeepalive**: Dieser Wert (in Sekunden) sorgt dafür, dass der Client regelmäßig kleine Datenpakete sendet, um NAT-Tables aufrechtzuerhalten, und verhindert, dass die Verbindung aufgrund von Inaktivität getrennt wird. Dies ist besonders nützlich bei Clients hinter einem NAT oder Router.

### Schlüsselgenerierung

Um die privaten und öffentlichen Schlüssel zu generieren, kannst du auf jedem Gerät den folgenden Befehl verwenden:

```bash
wg genkey | tee privatekey | wg pubkey > publickey
```

Dieser Befehl generiert den privaten Schlüssel und den öffentlichen Schlüssel. Der private Schlüssel wird in einer Datei namens `privatekey` gespeichert, und der öffentliche Schlüssel in einer Datei namens `publickey`.
