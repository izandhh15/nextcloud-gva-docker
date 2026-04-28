# Nextcloud GVA Zero-Touch 🚀

<p align="center">
  <img src="https://ceice.gva.es/documents/161863064/162818610/logo_Conselleria_transp_v.png" alt="Generalitat Valenciana" width="300">
</p>

Este projecte instal·la automàticament un **Nextcloud segur** per a centres educatius de la Comunitat Valenciana.

**Què fa este invent?**
- 👨‍🏫 **Només entren profes:** Només permet l'accés al professorat del TEU centre.
- 🚫 **Alumnes fora:** Bloqueja automàticament qualsevol compte que siga d'alumne (@alu.edu.gva.es).
- 🌐 **Xarxa Interna:** Preparat per a funcionar en la IP del teu centre.
- ⚙️ **Tot automàtic:** No has de configurar res dins de la web, l'script ho fa per tu.

---

## 🛠️ Guia per a novells (Pas a pas)

No cal ser un expert, només segueix estos 3 passos:

### 1. Descarrega el projecte
Entra en la carpeta on l'hages descarregat usant la terminal.

### 2. Configura les teues dades (L'assistent màgic)
Executa este comanda i **respon a les preguntes** que t'eixiran en pantalla (la IP del servidor, el codi del centre, la clau del LDAP, etc.):
```bash
./install.sh
```

### 3. Arrenca el motor!
Una vegada acabes de respondre, escriu açò perquè tot comence a instal·lar-se sol:
```bash
docker-compose up -d --build
```

Espera uns minuts, obri el teu navegador i posa la IP que has configurat (ej: `http://192.168.1.50:8080`).

---

## 🔒 Seguretat
Este projecte utilitza un arxiu ocult anomenat `.env` per a guardar les teues contrasenyes. **Mai compartisques este arxiu amb ningú**. L'assistent `install.sh` el crea per tu de forma segura.

---

### 👨‍💻 Desenvolupat per:
**Developed by [@izandhh](https://github.com/izandhh15)**

---
<p align="center">
  Fet amb ❤️ per a la comunitat educativa de la GVA.
</p>
