# Nextcloud GVA Zero-Touch 🚀

<p align="center">
  <img src="https://ceice.gva.es/documents/161863064/162818610/logo_Conselleria_transp_v.png" alt="Generalitat Valenciana" width="300">
</p>

Este proyecto instala automáticamente un **Nextcloud seguro** para centros educativos de la Comunitat Valenciana. 

**¿Qué hace este invento?**
- 👨‍🏫 **Solo entran profes:** Solo permite el acceso al profesorado de TU centro.
- 🚫 **Alumnos fuera:** Bloquea automáticamente a cualquier cuenta que sea de alumno (@alu.edu.gva.es).
- ⚙️ **Todo automático:** No tienes que configurar nada dentro de la web, el script lo hace por ti.

---

## 🛠️ Guía para novatos (Paso a paso)

No hace falta ser un experto, solo sigue estos 3 pasos:

### 1. Descarga el proyecto
Entra en la carpeta donde lo hayas descargado usando la terminal.

### 2. Configura tus datos (El asistente mágico)
Ejecuta este comando y **responde a las preguntas** que te saldrán en pantalla (el código de tu centro, la clave del LDAP, etc.):
```bash
./install.sh
```

### 3. ¡Arranca el motor!
Una vez termines de responder, escribe esto para que todo empiece a instalarse solo:
```bash
docker-compose up -d --build
```

Espera unos minutos, abre tu navegador y pon: `http://localhost:8080`

---

## 🔒 Seguridad
Este proyecto utiliza un archivo oculto llamado `.env` para guardar tus contraseñas. **Nunca compartas ese archivo con nadie**. El asistente `install.sh` lo crea por ti de forma segura.

---

### 👨‍💻 Desarrollado por:
**Developed by [@izandhh](https://github.com/izandhh15)**

---
<p align="center">
  Hecho con ❤️ para la comunidad educativa de la GVA.
</p>
