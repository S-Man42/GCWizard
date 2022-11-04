# **HOWTO Raspberry Pi Server**

<img src="C:\Users\thoma\OneDrive - EDV-Beratung und Softwareentwicklung\HOWTO raspi-Dateien\image001.png" style="zoom:80%;" />



# Inhaltsverzeichnis

[TOC]



# Raspberry Pi 4



## Hardware

Das Raspberry Pi 4 Model B ist mit einem Broadcom 2711, Quad-core CortexA72 64-bit SoC @ 1.5GHz sowie 8 GB SDRAM ausgestattet.

<img src="C:\Users\thoma\OneDrive - EDV-Beratung und Softwareentwicklung\HOWTO raspi-Dateien\image003.png" style="zoom:75%;" />

Weitere Details sind:

- 2.4GHz / 5.0GHz IEEE 802.11.b/g/n/ac Wireless LAN integriert

- Bluetooth 5.0, BLE

- 2 x USB 2.0 / 2 x USB 3.0 Ports 

- ein "echter" Gigabit Ethernet RJ45 Port
- HAT kompatibler 40-pin GPIO Header
- 2 x Micro HDMI
- 4K Video 1 X MIPI
- DSI Display Port
- 1 X MIPI CSI Camera Port
- 4 poliger Stereo Audio und Composite Video
- H.265 decode (4kp60)
- H.264 decode (1080p60)
- H.264 encode (1080p30)
- OpenGL ES 1.1, 2.0, 3.0 graphics
- Micro SD für OS & Datenspeicherung
- 5V/3A DC via USB type C Connector
- 5V DC via GPIO
- PoE fähig über optionale HAT Erweiterung



## Gehäuse

The Argon ONE M.2 Case ups the ante by providing the following:

- Two full-sized HDMI ports 

- Power Management Modes

- Built-in IR support 

- Integrated M.2 SATA SSD support

  ![](C:\Users\thoma\OneDrive - EDV-Beratung und Softwareentwicklung\HOWTO raspi-Dateien\image006.jpg)

  Argon ONE M.2 Case extended support for M.2 SATA SSDs allows you to maximize the true potential speeds of your Raspberry Pi 4. You will now be able to boot via an M.2 SATA SSD for faster boot times and larger storage capacity compared to the traditional microSD Card.

  Argon ONE M.2 is UASP Supported for the Raspberry Pi 4 which means you can maximize the transfer speeds of your M.2 SATA Drive.

  It is compatible with any M.2 SATA SSD with Key-B and Key B&M.



# Booten von der SSD



## Quellen

- [How to Boot a Raspberry Pi From SSD and Use It for Permanent Storage (makeuseof.com)](https://www.makeuseof.com/how-to-boot-raspberry-pi-ssd-permanent-storage/)
- [Raspberry Pi OS – Raspberry Pi](https://www.raspberrypi.com/software/)



## Things You Will Need

You will need the following items to enable SSD boot on Raspberry Pi.

- Raspberry Pi (4, 400, 3, Zero W, or Zero 2W model)
- microSD card (1GB minimum, 64GB maximum)
- microSD card reader
- Keyboard and mouse (both wireless or wired will work)—not required     if you want to enable SSD boot on a Raspberry Pi 4 or Pi 400
- Any type of external SSD (such as M.2, SATA, or NVMe/PCIe)



## Boot Raspberry Pi 4 from SSD

To boot Raspberry Pi 4 or Raspberry Pi 400 from SSD, you must enable USB boot:

1. Connect the microSD card to another computer using a card reader.
2. Download, install, and launch the [Raspberry Pi Imager](https://www.raspberrypi.com/software/) tool on your     Windows, Linux, or Mac system.
3. Click the Choose OS button and then click Misc     Utility Images > Bootloader > USB Boot.
4. Click the Choose Storage button and select the microSD     card connected to your system.
5. Click Write and wait for the flash process to complete.     It will take a few seconds only.
6. After the flash process, the microSD card is auto-ejected.     Disconnect the microSD card from the system and insert it into the microSD     slot of your Raspberry Pi 4 or 400.
7. Connect the power supply to the Raspberry Pi to turn it on. The Pi     will automatically read and flash the USB bootloader from the connected     microSD card. This takes a few seconds.
8. When the flash is successful, the green LED light on the Raspberry     Pi starts blinking steadily. To confirm further, connect the HDMI port to     a display. If the display shows a green screen, it indicates that the flash     process is complete.
9. Turn off the Raspberry Pi and disconnect or remove the microSD     card.



## Prepare Bootable Raspberry Pi SSD

To boot the Raspberry Pi via SSD, you must install an operating system, such as Raspberry Pi OS on the SSD by using Raspberry Pi Imager. After writing the OS, you can connect the SSD to the Raspberry Pi via a USB port and boot the OS from the SSD. To prepare the SSD for boot, follow these steps:

1. Launch the Raspberry Pi Imager tool and connect your external SSD     to the system via a USB port.
2. Click Choose OS to select the desired OS from the list.     If you want to flash a downloaded OS image, you can use the file by     clicking on the Custom option and then selecting the OS file     from your system.
3. Click Choose Storage to select the connected SSD storage     media.
4. Click the Write button.
5. After the OS is flashed on the SSD, dismount the drive and then     connect the USB drive to one of the USB 3.0 or 2.0 ports on your Raspberry     Pi 4/400, Raspberry Pi 3 (or to Zero W/2W’s micro-USB port via an     adapter).
6. Connect the power supply to turn on the Raspberry Pi.
7. The Raspberry Pi will check for a bootable SSD connected to the USB     port and boot the operating system.



## Raspberry PI Imager

<img src="C:\Users\thoma\OneDrive - EDV-Beratung und Softwareentwicklung\HOWTO raspi-Dateien\image007.png" style="zoom:50%;" />

| Auswahlmöglichkeit |                                                              |
| ------------------ | ------------------------------------------------------------ |
| Betriebssystem     | RASPBERRY PI OS LITE (64-BIT)                                |
| SD-Karte           | SSD-Karte                                                    |
| Einstellungen      | WLAN aktivieren<br />SSH aktivieren<br />Passwort setzen<br />Tastaturlayout DE |



# Installation SSH



## Quellen

- [How to Enable SSH on Raspberry Pi- Definitive Guide (phoenixnap.com)](https://phoenixnap.com/kb/enable-ssh-raspberry-pi#:~:text=To enable SSH using the raspi-config tool%3A 1,SSH server is enabled” confirmation box. Weitere Elemente)



## Installation

```
sudo raspi-config
```

<img src="C:\Users\thoma\OneDrive - EDV-Beratung und Softwareentwicklung\HOWTO raspi-Dateien\image009.png" style="zoom:50%;" />

Alternativ

```
sudo systemctl enable ssh
sudo systemctl start ssh
```



# Installation Midnight Commander

```
sudo apt-get install mc
```

Hinweis: immer als root ausführen

```
sudo mc
```

<img src="C:\Users\thoma\OneDrive - EDV-Beratung und Softwareentwicklung\HOWTO raspi-Dateien\image011.png" style="zoom:50%;" />



# Installation Apache2



## Quellen

- [How to Setup a Raspberry Pi Apache Web Server - Pi My Life Up](https://pimylifeup.com/raspberry-pi-apache/)



## Installation

```
sudo apt-get install apache2
```



## Konfiguration

Nach der Installation lauscht der Webserver Apache 2 auf dem Port 80.  Eine Änderung erolgt in der Datei $/etc/apache2/ports.conf$ mit dem Befehl `listen  to`

```
sudo nano /etc/apache2/ports.conf
```

Anschließend ist die Änderung der Konfiguration zu laden und der Webserver neu zu starten.

```
sudo systemctl reload apache2
```



# Installation nagios



## Quellen

- [Installing Nagios on the Raspberry Pi - Pi My Life Up](https://pimylifeup.com/raspberry-pi-nagios/)
- [Nagios Core - Installing Nagios Core From Source](https://support.nagios.com/kb/article/nagios-core-installing-nagios-core-from-source-96.html#Raspbian)
- [Nagios - Ports and Protocols (tutorialspoint.com)](https://www.tutorialspoint.com/nagios/nagios_ports_and_protocols.htm)
- [Nagios - The Industry Standard In IT Infrastructure Monitoring](https://www.nagios.org/)



## Installation

This guide is based on SELinux being disabled or in permissive mode. SELinux is not enabled by default on Debian. If you would like to see if it is installed run the following command:

```
sudo dpkg -l selinux*
```

### **Prerequisites**

Perform these steps to install the pre-requisite packages.

```
sudo apt-get update
sudo apt-get install -y autoconf gcc libc6 make wget unzip apache2 apache2-utils php libgd-dev
sudo apt-get install openssl libssl-dev
```

 

### **Downloading the Source**

```
cd /tmp
wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.6.tar.gz
tar xzf nagioscore.tar.gz
```

 

### **Compile**

```
cd /tmp/nagioscore-nagios-4.4.6/
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
sudo make all
```

 

### **Create User And Group**

This creates the nagios user and group. The www-data user is also added to the nagios group.

```
sudo make install-groups-users
sudo usermod -a -G nagios www-data
```

 add password for user

```
sudo passwd nagios
```



### **Install Binaries**

This step installs the binary files, CGIs, and HTML files.

```
sudo make install
```

 

### **Install Service/Daemon**

This installs the service or daemon files and also configures them to start on boot.

```
sudo make install-daemoninit
```

 

Information on starting and stopping services will be explained further on.

 

### **Install Command Mode**

This installs and configures the external command file.

```
sudo make install-commandmode
```



### **Install Configuration Files**

This installs the *SAMPLE* configuration files. These are required as Nagios needs some configuration files to allow it to start.

```
sudo make install-config
```

 

### **Install Apache Config Files**

This installs the Apache web server configuration files and configures the Apache settings.

```
sudo make install-webconf
sudo a2enmod rewrite
sudo a2enmod cgi
```

 

### **Configure Firewall**

You need to allow port 80 inbound traffic on the local firewall so you can reach the Nagios Core web interface.

```
sudo iptables -I INPUT -p tcp --destination-port 80 -j ACCEPT
sudo apt-get install -y iptables-persistent
```

Answer yes to saving existing rules

 

### **Create nagiosadmin User Account**

You'll need to create an Apache user account to be able to log into Nagios.

The following command will create a user account called nagiosadmin and you will be prompted to provide a password for the account.

```
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
```

 

When adding additional users in the future, you need to remove **-c** from the above command otherwise it will replace the existing nagiosadmin user *(and any other users you may have added)*.

 

### **Start Apache Web Server**

Need to restart it because it is already running.

```
sudo systemctl restart apache2.service
```

 

### **Start Service/Daemon**

This command starts Nagios Core.

```
sudo systemctl start nagios.service
```

 

### **Test Nagios**

Nagios is now running, to confirm this you need to log into the Nagios Web Interface.

Point your web browser to the ip address or FQDN of your Nagios Core server, for example *`http://10.25.5.143/nagios`* or *`http://core-013.domain.local/nagios`*

You will be prompted for a username and password. The username is nagiosadmin (you created it in a previous step) and the password is what you provided earlier.

Once you have logged in you are presented with the Nagios interface. Congratulations you have installed Nagios Core.

**BUT WAIT ...**

Currently you have only installed the Nagios Core engine. You'll notice some errors under the hosts and services along the lines of:

```
(No output on stdout) stderr: execvp(/usr/local/nagios/libexec/check_load, ...) failed. errno is 2: No such file or directory 
```

These errors will be resolved once you install the Nagios Plugins, which is covered in the next step.

 

### **Installing The Nagios Plugins**

Nagios Core needs plugins to operate properly. The following steps will walk you through installing Nagios Plugins.

These steps install nagios-plugins 2.3.3. Newer versions will become available in the future and you can use those in the following installation steps. Please see the [releases page on GitHub](https://github.com/nagios-plugins/nagios-plugins/releases) for all available versions.

Please note that the following steps install most of the plugins that come in the Nagios Plugins package. However there are some plugins that require other libraries which are not included in those instructions. Please refer to the following KB article for detailed installation instructions:

[Documentation - Installing Nagios Plugins From Source](https://support.nagios.com/kb/article.php?id=569)

 

#### **Prerequisites**

Make sure that you have the following packages installed.

```
sudo apt-get install -y autoconf gcc libc6 libmcrypt-dev make libssl-dev wget bc gawk dc build-essential snmp libnet-snmp-perl gettext
```

 

#### **Downloading The Source**

```
cd /tmp
wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.3.3.tar.gz
tar zxf nagios-plugins.tar.gz
```

 

#### **Compile + Install**

```
cd /tmp/nagios-plugins-release-2.3.3/
sudo ./tools/setup
sudo ./configure
sudo make
sudo make install
```

 

#### **Test Plugins**

Point your web browser to the ip address or FQDN of your Nagios Core server, for example: *`http://10.25.5.143/nagios`* or *`http://core-013.domain.local/nagios`*. 

Go to a host or service object and "Re-schedule the next check" under the Commands menu. The error you previously saw should now disappear and the correct output will be shown on the screen.

 

#### **Service/Daemon Commands**

Different Linux distributions have different methods of starting / stopping / restarting / status Nagios.

```
sudo systemctl start nagios.service
sudo systemctl stop nagios.service
sudo systemctl restart nagios.service
sudo systemctl status nagios.service
```



## Konfiguration 

Die Konfigurationsdateien sind zu finden unter `/usr/local/nagios/etc` sowie  `/usr/local/nagios/etc/objects` .

| Datei                                         | Bedeutung                                                    |
| --------------------------------------------- | ------------------------------------------------------------ |
| /usr/local/nagios/etc/nagios.cfg              | Haupt-Konfigurationsdatei. Hier wird definiert<br />- Konfiguration der LOG-Datei<br />- alle weiteren zu nutzenden Konfigurationsdateien |
| /usr/local/nagios/etc/objects/commands.cfg    | Definition der Befehle                                       |
| /usr/local/nagios/etc/objects/contacts.cfg    | Definition der Kontaktdaten                                  |
| /usr/local/nagios/etc/objects/localhost.cfg   | Definition des hosts und der durchzuführenden Prüfungen      |
| /usr/local/nagios/etc/objects/printer.cfg     | Vorlage für das Monitoring eines Druckers                    |
| /usr/local/nagios/etc/objects/switch.cfg      | Vorlage für das Monitoring eines Switches                    |
| /usr/local/nagios/etc/objects/templates.cfg   | Vorlagen für Definitionen von Befehlen, hosts, Gruppen, Kontakten, … |
| /usr/local/nagios/etc/objects/timeperiods.cfg | Vorlagen für Zeiten, Zeitintervalle, …                       |
| /usr/local/nagios/etc/objects/windows.cfg     | Vorlage für das Monitoring eines Windows-Rechners (Server, Client) |

### Anpassungen in der Datei localhost.cfg

Ergänzen der Port-Nummer des Apache-Webservers

```
define service{
    use                    local-service
    host_name              localhost
    service_description    HTTP
    check_command          check_http!-p 1417
    notification_enabled   1
}
```



### Anpassungen für Tomcat

#### Quellen

- [Configure Tomcat's Plugin in Nagios (Ubuntu) – The geeky Argonaut – Experiences on software craftmanship (zouzias.org)](https://www.zouzias.org/2015/02/26/Tomcat-Plugin-in-Nagios/)
- [check_tomcat.pl - Nagios Exchange](https://exchange.nagios.org/directory/Plugins/Java-Applications-and-Servers/Apache-Tomcat/check_tomcat-2Epl/details)



#### Installation

1. Download the [Tomcat plugin](http://exchange.nagios.org/directory/Plugins/Java-Applications-and-Servers/Apache-Tomcat/check_tomcat-2Epl/details) into `/usr/local/nagios/libexec/` directory (into your nagios server). 
   
2. Rename the plugin from `check_tomcat.pl` to `check_tomcat`and make it executable.
   
3. Just to be on the safe side, install a XML dependency that is used by the tomcat plugin using

   ```
   sudo apt-get install libxml-xpath-perl
   ```

   

4. Append the following lines in the file `/usr/lical/nagios/objects/commands.cfg`

   ```
   # check_tomcat command definition
   define command{
          command_name check_tomcat
          command_line /usr/bin/perl /usr/local/nagios/libexec/check_tomcat -H $HOSTADDRESS$ -p $ARG1$ -l $ARG2$ -a $ARG3$ -w $ARG4$ -c $ARG5$
   }
   ```

   

5. Add the following service definition in the host that you want to check if Tomcat is running. In our case we will use localhost. 

   ```
   # Define a service to check the state of a Tomcat service
   define service{
          use                  local-service
          host_name            localhost
          service_description  Tomcat
          check_command        check_tomcat!7323!tomcat_username!tomcat_password!25%,25%!10%,10%
   }
   ```

   

6. Finally, restart nagios using

   ```
   sudo systemctl restart nagios.service
   ```

   



### Anpassungen für Waveshare UPS Hat

python-script für die Abfrage erstellen

```
sudo nano /usr/local/nagios/libexec/check_ups_hat
```

```
#!/usr/bin/python3
import smbus2
import smbus
import time
import os

OK = 0
WARNING = 1
CRITICAL = 2
UNKNOWN = 3

_REG_CONFIG                 = 0x00
_REG_SHUNTVOLTAGE           = 0x01
_REG_BUSVOLTAGE             = 0x02
_REG_POWER                  = 0x03
_REG_CURRENT                = 0x04
_REG_CALIBRATION            = 0x05

class BusVoltageRange:
    RANGE_16V               = 0x00      # set bus voltage range to 16V
    RANGE_32V               = 0x01      # set bus voltage range to 32V (default)

class Gain:
    DIV_1_40MV              = 0x00      # shunt prog. gain set to  1, 40 mV range
    DIV_2_80MV              = 0x01      # shunt prog. gain set to /2, 80 mV range
    DIV_4_160MV             = 0x02      # shunt prog. gain set to /4, 160 mV range
    DIV_8_320MV             = 0x03      # shunt prog. gain set to /8, 320 mV range

class ADCResolution:
    ADCRES_9BIT_1S          = 0x00      #  9bit,   1 sample,     84us
    ADCRES_10BIT_1S         = 0x01      # 10bit,   1 sample,    148us
    ADCRES_11BIT_1S         = 0x02      # 11 bit,  1 sample,    276us
    ADCRES_12BIT_1S         = 0x03      # 12 bit,  1 sample,    532us
    ADCRES_12BIT_2S         = 0x09      # 12 bit,  2 samples,  1.06ms
    ADCRES_12BIT_4S         = 0x0A      # 12 bit,  4 samples,  2.13ms
    ADCRES_12BIT_8S         = 0x0B      # 12bit,   8 samples,  4.26ms
    ADCRES_12BIT_16S        = 0x0C      # 12bit,  16 samples,  8.51ms
    ADCRES_12BIT_32S        = 0x0D      # 12bit,  32 samples, 17.02ms
    ADCRES_12BIT_64S        = 0x0E      # 12bit,  64 samples, 34.05ms
    ADCRES_12BIT_128S       = 0x0F      # 12bit, 128 samples, 68.10ms

class Mode:
    POWERDOW                = 0x00      # power down
    SVOLT_TRIGGERED         = 0x01      # shunt voltage triggered
    BVOLT_TRIGGERED         = 0x02      # bus voltage triggered
    SANDBVOLT_TRIGGERED     = 0x03      # shunt and bus voltage triggered
    ADCOFF                  = 0x04      # ADC off
    SVOLT_CONTINUOUS        = 0x05      # shunt voltage continuous
    BVOLT_CONTINUOUS        = 0x06      # bus voltage continuous
    SANDBVOLT_CONTINUOUS    = 0x07      # shunt and bus voltage continuous


class INA219:
    def __init__(self, i2c_bus=1, addr=0x40):
        self.bus = smbus.SMBus(i2c_bus);
        self.addr = addr

        self._cal_value = 0
        self._current_lsb = 0
        self._power_lsb = 0
        self.set_calibration_32V_2A()

    def read(self,address):
        data = self.bus.read_i2c_block_data(self.addr, address, 2)
        return ((data[0] * 256 ) + data[1])

    def write(self,address,data):
        temp = [0,0]
        temp[1] = data & 0xFF
        temp[0] =(data & 0xFF00) >> 8
        self.bus.write_i2c_block_data(self.addr,address,temp)

    def set_calibration_32V_2A(self):
        self._current_lsb = .1  # Current LSB = 100uA per bit
        self._cal_value = 4096
        self._power_lsb = .002  # Power LSB = 2mW per bit
        self.write(_REG_CALIBRATION,self._cal_value)
        self.bus_voltage_range = BusVoltageRange.RANGE_32V
        self.gain = Gain.DIV_8_320MV
        self.bus_adc_resolution = ADCResolution.ADCRES_12BIT_32S
        self.shunt_adc_resolution = ADCResolution.ADCRES_12BIT_32S
        self.mode = Mode.SANDBVOLT_CONTINUOUS
        self.config = self.bus_voltage_range << 13 | \
                      self.gain << 11 | \
                      self.bus_adc_resolution << 7 | \
                      self.shunt_adc_resolution << 3 | \
                      self.mode
        self.write(_REG_CONFIG,self.config)

    def getShuntVoltage_mV(self):
        self.write(_REG_CALIBRATION,self._cal_value)
        value = self.read(_REG_SHUNTVOLTAGE)
        if value > 32767:
            value -= 65535
        return value * 0.01

    def getBusVoltage_V(self):
        self.write(_REG_CALIBRATION,self._cal_value)
        self.read(_REG_BUSVOLTAGE)
        return (self.read(_REG_BUSVOLTAGE) >> 3) * 0.004

    def getCurrent_mA(self):
        value = self.read(_REG_CURRENT)
        if value > 32767:
            value -= 65535
        return value * self._current_lsb

    def getPower_W(self):
        self.write(_REG_CALIBRATION,self._cal_value)
        value = self.read(_REG_POWER)
        if value > 32767:
            value -= 65535
        return value * self._power_lsb
        
if __name__=='__main__':

    ina219 = INA219(addr=0x42)
    bus_voltage = ina219.getBusVoltage_V()             # voltage on V- (load side)
    shunt_voltage = ina219.getShuntVoltage_mV() / 1000 # voltage between V+ and V- across the shunt
    current = ina219.getCurrent_mA()                   # current in mA
    power = ina219.getPower_W()                        # power in W
    p = (bus_voltage - 6)/2.4*100
    if(p > 100):p = 100
    if(p < 0):p = 0

    print("{:3.1f}%, {:6.3f}V,{:9.6f}A, {:6.3f}W".format(p, bus_voltage, current/1000, power))
    if (current > 0): sys.exit(OK)
    if (p > 25): sys.exit(WARNING)
    if (p > 5):  sys.exit(CRITICAL)
    os.system("shutdown /s /t 1")
```



Die Datei ausführbar machen

```
sudo chmod 755 /usr/local/nagios/etc/objects/commands.cfg
```



nagios für die Ausführung dieser Datei in der Datei `sudoers` befähigen.

```
sudo visudo
```

```
nagios ALL=NOPASSWD: /usr/local/nagios/libexec/check_ups_hat
```



Befehl in der Datei `commands.cfg` erstellen

```
sudo nano /usr/local/nagios/etc/objects/commands.cfg
```

```
define command{
       command_name          check_ups_hat
       command_line          sudo /usr/bin/python /usr/local/nagios/libexec/check_ups_hat
}
```



Service in der Datei `localhost.cfg` erstellen

```
sudo nano /usr/local/nagios/etc/objects/localhost.cfg
```

```
define service{
       use                   local_service
       host_name             localhost
       service_description   UPS_HAT
       check_command         check_ups_hat
}
```



nagios erneut starten

```
sudo systemctl restart nagios.service
```





# Installation java



## Quellen

- http://java.xrheingauerx.de/raspberry_java_installieren.html



## Installation

Das OpenJDK wird in das *`/usr/lib/jvm/`* Verzeichnis installiert. Dort legen wir später einen symbolischen Link an, damit wir Java einfach aktualisieren können, ohne die Grundkonfiguration jedesmal dafür ändern zu müssen. Zudem können wir den Link einfach auf eine andere Java-Version zeigen lassen und z. B. der Tomcat würde diese Version dann nutzen.

Wir installieren auch nur die Runtime (JRE), da wir auf diesem Pi nichts entwickeln, sondern nur laufen lassen.



## Installation

Zunächst einmal aktualisieren wir die Paketlisten mit folgendem Befehl

```
sudo apt-get update
```

Danach installieren wir das OpenJDK mit

```
sudo apt-get install openjdk-11-jre
```

Nun legen wir einen symbolischen Link *`/usr/lib/jvm/java`* an, der auf dieses Verzeichnis zeigt und den wir später in anderen Programmen oder Diensten, z. B. im Tomcat, nutzen können.

```
sudo ln -s /usr/lib/jvm/java-11-openjdk-arm64 /usr/lib/jvm/java
```

Nun müssen wir die Umgebungsvariable  *`JAVA_HOME`*  so konfigurieren, dass Java-Anwendungen das Java-Installationsverzeichnis finden können. Tomcat benötigt eine JAVA_HOME-Umgebung, um korrekt eingerichtet zu werden. Hierzu ist in der Umgebungsdatei /etc/environments die JAVA_HOME-Umgebung zu ergänzen.

```
sudo nano /etc/environment
```

 

```
JAVA_HOME="/usr/lib/jvm/java"
```

Bearbeiten Sie anschließend die .bashrc-Datei und fügen Sie Zeilen hinzu, um die JAVA_HOME-Umgebungsvariablen zu exportieren:

```
sudo nano ~/.bashrc
```

Fügen Sie am Ende der Datei die untenstehende Konfiguration ein:

```
export JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre
export PATH=$JAVA_HOME/bin:$PATH
```

Speichern und beenden Sie die Datei und laden Sie dann die.bashrc-Datei neu.

```
source ~/.bashrc
```



# Installation Tomcat



## Quellen

- http://java.xrheingauerx.de/raspberry_tomcat_installieren.html
- https://linuxhint.com/change-default-port-of-tomcat-server/#:~:text=Changing%20Default%20Port%201%201.%20Locating%20the%20Server.xml,Port%20Number%20...%204%204.%20Restarting%20Tomcat%20
- https://www.howtoforge.de/anleitung/so-installieren-und-konfigurieren-sie-apache-tomcat-85-unter-ubuntu-1604/
- https://tomcat.apache.org/



Wir richten einen separaten User "tomcat" ein und lassen den Tomcat im Anschluss als Dienst auf dem Raspberry unter diesem Benutzer laufen.



## Benutzer tomcat anlegen

```
sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
```



## Installation

Wir wechseln in das Temp-Verzeichnis und laden uns die Zip-Datei des aktuellen Tomcat (Core) herunter (Stand 21.03.2020 = 8.5.53). Danach entpacken wir die ZIP-Datei. Wir stellen sicher, dass innerhalb dem "/opt" das Verzeichnis " tomcat " existiert und verschieben den entpackten Tomcat in das neu erstellte Verzeichnis. Im Anschluss löschen wir das Zip-File im /tmp-Ordner. Nun legen wir noch einen symbolischen Link "/opt/tomcat/home" an und legen tomcat als Besitzer des Verzeichnisses "/opt/tomcat" fest. Abschließend werden die Skripte innerhalb dem "bin"-Verzeichnis ausführbar gemacht.

```
cd /tmp
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.27/bin/apache-tomcat-10.0.27.zip
unzip apache-tomcat-*.zip
sudo mkdir -p /opt/tomcat
sudo mv apache-tomcat-8.5.83 /opt/tomcat/
sudo rm apache-tomcat-8.5.83.zip
sudo ln -s /opt/tomcat/apache-tomcat-8.5.83 /opt/tomcat/home
sudo chown -R tomcat: /opt/tomcat
sudo sh -c 'chmod +x /opt/tomcat/home/bin/*.sh'
```

Um den Tomcat auf dem Raspberry als Dienst laufen zu lassen, legen wir innerhalb "systemd" eine Unit-Datei mit dem Namen "tomcat.service" an.

```
sudo nano /etc/systemd/system/tomcat.service
```

Inhalt der Datei:

```
[Unit]
Description=Apache Tomcat Webserver
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="JAVA_HOME=/usr/lib/jvm/java"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"

Environment="CATALINA_HOME=/opt/tomcat/home"
Environment="CATALINA_BASE=/opt/tomcat/home"
Environment="CATALINA_PID=/opt/tomcat/home/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/home/bin/startup.sh
ExecStop=/opt/tomcat/home/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
```

 

Wir prüfen jetzt, ob der Tomcat auch sauber startet und geben der Reihenfolge nach folgende Befehle ein

```
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl status tomcat
```

 

Im Ok-Fall wollen wir, dass der Dienst bei jedem Start des Raspberry automatisch startet. Das erledigen wir mit folgendem Befehl

```
sudo systemctl enable tomcat
```

 

## Umgebungsvariable "Produktion" setzen

Da der Webserver als (private) Produktionsumgebung dient, auf der unsere Programme nach Fertigstellung laufen, erhält dieser eine entsprechende Umgebungsvariable. Wer diese in seinem Programm ausgibt, sieht in welcher Umgebung er sich gerade befindet.

 

Dazu bearbeiten wir die "server.xml" des Tomcats mit diesem Befehl und fügen das folgende unter den "GlobalNamingResources" ein:

```
sudo nano /opt/tomcat/home/conf/server.xml
<Environment description="Umgebung" name="UMGEBUNG" type="java.lang.String" value="Produktion"/>
```

![](C:\Users\thoma\OneDrive - EDV-Beratung und Softwareentwicklung\HOWTO raspi-Dateien\image014.jpg)

 

## Tomcat Manager App von außen zugänglich machen

Aus Sicherheitsgründen ist die Tomcat-Manager-App sowie die Tomcat-Hostmanager-App nur vom lokalen Raspberry aus nutzbar. Wir befinden uns aber im Heimnetz und möchten zumindest Zugriff auf die Manager-App von einem anderen Rechner aus, auf dem auch unser PuTTY (SSH-Client) läuft. Dazu müssen wir lediglich die jeweilige context.xml der App umkonfigurieren.

 

#### Editieren der Datei "tomcat-users.xml" 

```
sudo nano /opt/tomcat/home/conf/tomcat-users.xml
```

Anzupassender Inhalt: Anfügen ans Ende (aber vor "</tomcat-users>") :

```
<role rolename="admin"/>
<role rolename="admin-gui"/>
<role rolename="manager-gui"/>

<user username="USER" password="PASSWORD" roles="admin,admin-gui,manager-gui"/>
```

Achtung:  

- USER und PASSWORD ersetzen! 
-  Benutzer ist beliebig wählbar und das Passwort sowieso.

 

#### Editieren der Datei "context.xml" der Tomcat-Manager-App. 

```
sudo nano /opt/tomcat/home/webapps/manager/META-INF/context.xml
```

Dort tragen wir getrennt durch "|" die IP-Adressen der Rechner ein, die auch Zugriff auf die Manager-App haben sollen. 

![](C:\Users\thoma\OneDrive - EDV-Beratung und Softwareentwicklung\HOWTO raspi-Dateien\image018.jpg)



#### Wir starten nun den Tomcat neu, damit die Änderungen wirksam werden

```
sudo systemctl restart tomcat
```

 

## Changing Default Port

By default, the Tomcat server runs on the 8080 Port number. However, if there comes a need to change this, then it can be done easily by changing the port in the server.xml-File.

#### Edititieren der Datei /opt/tomcat/home/conf/server.xml

```
sudo nano /opt/tomcat/home/conf/server.xml
```

Anzupassender Inhalt

```
<Connector port="xxxx" protocol=“http/1.1“ …/>
```



# Installation des GCWizardDecompiler-servlet

- Öffne das Servlet Projekt in Eclipse
- Wähle File > Export > Web: WAR File
- Setze einen Dateinamen und Speicherort
- [Optional: Optimieren für spezifische Server Version]
- Öffne den Tomcat Manager
- Im Abschnitt "Lokale WAR Datei zur Installation hochladen"
  - Wähle WAR vom Speicherort
  - Klicke "Installieren"
- Teste Servlet mit `curl -F file=@<path_to_luac_file> <server_url>`

# Installation python3



## Quellen

- [Welcome to Python.org](https://www.python.org/)
- [How To Install the Latest Python Version on Raspberry Pi? – RaspberryTips](https://raspberrytips.com/install-latest-python-raspberry-pi/)



Two versions of Python come preinstalled on Raspberry Pi OS: Python 2 and Python 3. To find the exact version number, use the command line `python –version` and `python3 –version`.

The easiest way to find the latest Python release available is to go to the official Python website. On the download page, the latest versions are listed with their release date and maintenance status.



## Installation

Go to the tmp-Directory

```
cd /tmp
```

Download the latest Python file with

```
wget https://www.python.org/ftp/python/3.9.15/Python-3.9.15.tgz
```

Extract the files with

```
tar -zxvf Python-3.9.15.tgz
```

Move to the folder containing the extracted files

```
cd Python-3.9.15
```

Run the configuration command

```
./configure --enable-optimizations
```

Once done, run this command to install it

```
sudo make altinstall
```

Make Python the default version on Raspberry Pi OS

```
python3.9 myscript.py
```



## Installation des Paketmanagers PIP

```
sudo apt-get install python3-pip
```



## Installation des Paketes smbus

```
sudo pip install smbus --system
```



# Uninterruptable Power Supply



## Quellen

- [UPS HAT - Waveshare Wiki](https://www.waveshare.com/wiki/UPS_HAT)



## Features

- Standard Raspberry Pi 40PIN GPIO extension header, supports Raspberry Pi series boards.
- I2C bus communication, monitoring the batteries voltage, current, power, and remaining capacity in real-time.
- Multi battery protection circuits: overcharge/discharge protection, over current protection, short circuit protection, and reverse protection, along with the equalizing charge feature, more safe and stable.
- Onboard 5V regulator, up to 2.5A continuous output current.
- 5V USB output, convenient for powering other boards.
- Batteries warning indicators, easy to check if the battery is connected correctly.



## Specifications

- Output voltage：       5V
- Charger：                    8.4V 2A
- Control bus：              I2C
- Battery supported：  18650 Li battery (NOT included)
- Dimensions：              56mm × 85mm
- Mounting hole：         3.0mm



## Hardware

| Bild                                                         | Beschreibung                                                 |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](C:\Users\thoma\OneDrive - EDV-Beratung und Softwareentwicklung\HOWTO raspi-Dateien\image020.jpg) | Note that the 8.4V interface is the charging port. You can plug the 8.4V/2A charger provided for charging the batteries.<br/> The switch is the power switch, you can turn it into ON/OFF to turn on/off Jetson Nano Developer Kit.<br/> WARNING LED are the indicators of batteries, they turn on if you reverse batteries.<br/> Note 1: Please check the WARNING LED when you install batteries, make sure that you set all the batteries in the correct way. Don't charge batteries if you reverse them.<br/> Note 2: The board may not work when you install the batteries for the first time, you need to charge the batteries for a while to activate them.<br/> Note 3: Please use the charger provided, the module may be destroyed by other unsuitable power adapters/chargers. |



## Enable I2C Interface

Open the terminal of Raspberry Pi, and enter the following commands for the configuration interface:

```
sudo raspi-config
```

Select Interfacing Options -> I2C ->yes to start the i2C kernel driver.

```
sudo reboot
```

You can just attach the UPS HAT on the 40PIN GPIO of Raspberry Pi or connect the i2c interface and to Raspberry Pi by wires. VCC should be connected to 3.3V

Open a terminal and run the following commands:

```
sudo apt-get install p7zip
wget https://www.waveshare.com/w/upload/d/d9/UPS_HAT.7z
7zr x UPS_HAT.7z -r -o./UPS_HAT
cd UPS_HAT
python3 INA219.py
```

Obviously two errors could occur:

- python3 is not installed
- the smbus module is not installed

Hence you have to install python3 and the smbus module.





# Konfigurationsdaten

## Raspberry

| Schlüssel         | Wert |
| ----------------- | ---- |
| Benutzer Name     | pi   |
| Benutzer Kennwort |      |



## Tomcat

| Schlüssel                                      | Wert                                                    |
| ---------------------------------------------- | ------------------------------------------------------- |
| Port                                           | 7323                                                    |
| Benutzer Name                                  | GCWizardDecompiler                                      |
| Benutzer Kennwort                              |                                                         |
| IP-Adresse für den Zugriff auf die manager-GUI | 192.168.178.45<br />192.168.178.93<br />192.168.178.194 |
| Servlet-Verzeichnis                            | /GCW_Unluac                                             |

## nagios

| Schlüssel         | Wert        |
| ----------------- | ----------- |
| Benutzer Name     | nagiosadmin |
| Benutzer Kennwort |             |
| Port              | 1417        |

### check Tomcat

| /usr/local/nagios/libexec | check_tomcat.pl generieren                                   |
| ------------------------- | ------------------------------------------------------------ |
| commands.cfg              | define command{<br/>       command_name check_tomcat<br/>       command_line /usr/bin/perl /usr/lib/nagios/plugins/check_tomcat -H$HOSTADDRESS$ -p$ARG1$ -l$ARG2$ -a$ARG3$ -w$ARG4$ -c$ARG5$<br/>} |
| localhost.cfg             | define service{<br />        use                  local-service<br />        host_name            localhost<br />        service_description  Tomcat <br />       check_command        check_tomcat!7323!tomcat_username!tomcat_password!25%,25%!10%,10%<br /> } |

### check UPS_hat

| /usr/local/nagios/libexec | check_ups_hat.pl generieren                                  |
| ------------------------- | ------------------------------------------------------------ |
| commands.cfg              | define command{<br/>       command_name check_ups_hat<br/>       command_line echo <PASSWORD> \| sudo -S /usr/bin/python /usr/lib/nagios/plugins/check_ups_hat<br/>} |
| localhost.cfg             | define service{<br />        use                  local-service<br />        host_name            localhost<br />        service_description  UPS_HAT <br />       check_command        check_ups_hat<br /> } |

## Apache 2

| Schlüssel | Wert |
| --------- | ---- |
| Port      | 1417 |



## myFritz-Zugriff

| Schlüssel | Wert                                |
| --------- | ----------------------------------- |
| Adresse   | http://sdklmfoqdd5qrtha.myfritz.net |



## Servlet

| Schlüssel    | Wert                                                 |
| ------------ | ---------------------------------------------------- |
| Zugriffsart  | MultipartRequest                                     |
| Methode      | POST                                                 |
| Adresse      | http://sdklmfoqdd5qrtha.myfritz.net:7323/GCW_Unluac/ |
| Datentyp     | MultipartFile                                        |
| Content-Type | application, octet-stream                            |

