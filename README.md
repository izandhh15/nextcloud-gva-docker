# Nextcloud GVA Zero-Touch 🚀 (Edició Professorat)

<p align="center">
  <img src="https://ceice.gva.es/documents/161863064/162818610/logo_Conselleria_transp_v.png" alt="Generalitat Valenciana" width="300">
</p>

---

## 🇪🇸 Castellano

### ¿Qué es Nextcloud?
Nextcloud es una plataforma de productividad de código abierto que permite el almacenamiento, sincronización y compartición de archivos (como Google Drive o OneDrive), pero **alojada en tu propio servidor**. Esto garantiza que los datos nunca salgan del centro educativo.

### Objetivo del Proyecto
Este proyecto ofrece una **alternativa independiente** a las plataformas de Microsoft (Teams, OneDrive) de la GVA. El objetivo es que los centros educativos gestionen sus propios recursos de forma soberana, segura y sin depender de servicios externos de grandes corporaciones.

---

### 🛠️ Manual de Instalación Paso a Paso

#### 1. Requisitos previos
- Tener instalado **Docker** y **Docker Compose**.
- Estar en la red interna del centro para conectar con el LDAP.

#### 2. Ejecutar el asistente
Elige el idioma del asistente. Esto también configurará el idioma de Nextcloud:
- En Castellano: `./instalar_es.sh`
- En Valencià: `./instala_va.sh`

#### 3. Preguntas del asistente (Explicación)
El script te pedirá los siguientes datos:
1.  **IP interna del servidor**: La dirección IP local del ordenador donde instalas Nextcloud (ej: 192.168.1.50).
2.  **Puerto para el servicio**: Por defecto 8080. Es el puerto que pondrás en el navegador.
3.  **Clave ROOT MariaDB**: Contraseña maestra para la base de datos (se genera una al azar si la dejas en blanco).
4.  **Clave usuario Nextcloud DB**: Contraseña para el acceso de la aplicación a los datos.
5.  **Nombre administrador web**: El usuario "jefe" para entrar a Nextcloud (ej: admin).
6.  **Contraseña administrador web**: La clave para ese usuario.
7.  **Servidor LDAP GVA**: Por defecto `ldapad.edu.gva.es`.
8.  **DN Agente consulta**: El usuario que lee el LDAP (ej: `cn=consulta_DA,ou=educacion,dc=edu,dc=gva,dc=es`).
9.  **Contraseña consulta**: La contraseña de ese usuario (necesaria para conectar).
10. **Base de búsqueda**: `dc=edu,dc=gva,dc=es`.
11. **Código centro**: Tu código de centro (ej: 46026160). **Esto es vital para que solo entren tus profes.**

#### 4. Lanzar el servicio
Una vez finalizado el asistente, escribe:
```bash
docker-compose up -d --build
```

---

##  Valencià

### Què és Nextcloud?
Nextcloud és una plataforma de productivitat de codi obert que permet l'emmagatzematge de fitxers (com Google Drive o OneDrive), però **allotjada en el teu propi servidor**.

### Objectiu del Projecte
Este projecte ofereix una **alternativa independent** a les plataformes de Microsoft imposades en els centres. L'objectiu és la **sobirania tecnològica**: gestionar els recursos de forma segura i sense dependre de multinacionals.

---

### 🛠️ Manual d'Instal·lació Pas a Pas

#### 1. Requisits previs
- Tindre instal·lat **Docker** i **Docker Compose**.

#### 2. Executar l'assistent
- En Valencià: `./instala_va.sh` (Açò posarà Nextcloud en valencià).
- En Castellà: `./instalar_es.sh`

#### 3. Preguntes de l'assistent (Explicació)
L'script et demanarà:
1.  **IP interna del servidor**: La IP local del servidor (ej: 192.168.1.50).
2.  **Port per al servei**: Per defecte 8080.
3.  **Clau ROOT MariaDB**: Contrasenya mestra de la base de dades.
4.  **Clau usuari Nextcloud DB**: Contrasenya d'accés per a l'aplicació.
5.  **Nom administrador web**: L'usuari per a entrar a la web (ej: admin).
6.  **Contrasenya administrador web**: La clau per a eixe usuari.
7.  **Servidor LDAP GVA**: `ldapad.edu.gva.es`.
8.  **DN Agent consulta**: L'usuari que llegeix l'LDAP.
9.  **Contrasenya consulta**: La clau d'eixe usuari de consulta.
10. **Base de cerca**: `dc=edu,dc=gva,dc=es`.
11. **Codi centre**: El codi del teu centre (ej: 46026160). **Açò assegura que només entren els teus profes.**

#### 4. Llançar el servei
Escrit:
```bash
docker-compose up -d --build
```

---

## 👨‍💻 Desenvolupat per / Desarrollado por:
**[@izandhh](https://github.com/izandhh15)**

## 📜 Llicència / Licencia
**CC BY-NC 4.0** - Reconeixement-NoComercial 4.0 Internacional.

---
<p align="center"> Fet per a la independència tecnològica dels centres valencians. </p>
