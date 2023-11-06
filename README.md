<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="https://raw.githubusercontent.com/awais-amjed/images/4c3de5354d477c0daeac868664cd3ae3311a02b3/logo.svg" alt="Project logo"></a>
</p>

---

<p align="center"> LOOFT Management Dashboard
    <br>
</p>

## 📝 Table of Contents
- [About](#about)
- [Getting Started](#getting_started)
- [Usage](#usage)
- [Built Using](#built_using)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)

## 🧐 About <a name = "about"></a>
Welcome to LOOFT Management Dashboard, the ultimate solution for managing your IoT devices and users. IoT Dashboard is a web-based application that lets you monitor your IoT devices from anywhere. You can also manage your users, assign roles and permissions, and create custom templates for different scenarios.

With IoT Dashboard, you can:

- View real-time and historical data from your devices using interactive charts and tables.
- Manage your users and their access to your devices and data.
- Create custom templates for different use cases and share them with your users or customers.

This app also lets you outsource the dashboard by letting you create multiple Companies and all their data and users will be separated.

## Demo
You can try a live demo [here](https://looft-dashboard.web.app/). Please use the following credentials to login.

```
Email:    test@test.com
Password: test12345
```
This is a test account with monitor permissions (You only have read access).

## 🏁 Getting Started <a name = "getting_started"></a>
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites
What things you need to install the software and how to install them.

```
Flutter v3.13.9
Android Studio
```

### Setup

1. Clone the project.
2. Open the project in Android Studio.
3. Add Your Firebase Configuration to the project following the instructions [here](https://firebase.google.com/docs/flutter/setup?platform=web).
4. Update Maps API Key in lib/constants.dart & web/index.html. Make sure that your API key has access to the required APIs in the GCloud console (Geocoding API, Maps Embeded API, Maps Javascript API and Places API).
5. Setup the Firebase Directory Structure following [IoT Data Structure.pdf](https://github.com/LOOFTInc/LOOFT-Management-Dashboard/blob/main/IoT%20Data%20Structure.pdf).
6. Setup User Roles with [Custom Claims](https://firebase.google.com/docs/auth/admin/custom-claims) following [Firebase Firestore Roles.pdf](https://github.com/LOOFTInc/LOOFT-Management-Dashboard/blob/main/Firebase%20Firestore%20Roles.pdf).
7. You will also need to setup Cloud functions from this [repository](https://github.com/LOOFTInc/LOOFT-IoT-Dashboard-Functions) for all the functionalities to work.

If you need more help feel free to contact us.

## 🎈 Usage <a name="usage"></a>
```
run 'main.dart'
```

For details about the project you can check this dart generated [documentation](https://looft-dashboard-doc.web.app/).

If you need help getting started with Flutter please visit the [Flutter](https://docs.flutter.dev/get-started/install) website.

_Note: The Code in this repository is for [personal use only](https://github.com/LOOFTInc/LOOFT-Management-Dashboard/blob/main/LICENSE), if you want to use our product commercially or need a fully functional dashboard, feel free to contact us at [info@joinlooft.com](mailto:info@joinlooft.com)_

## ⛏️ Built Using <a name = "built_using"></a>
- [Flutter](https://flutter.dev/) - Framework
- [Firebase](https://firebase.google.com/) - Database

## ✍️ Authors <a name = "authors"></a>
- [@awais-amjed](https://github.com/awais-amjed) - Full Stack Developer
- [@Saad-Imtiaz](https://github.com/Saad-Imtiaz) - UI Designer & IoT Developer

## 🎉 Acknowledgements <a name = "acknowledgement"></a>
- [LOOFT Inc.](https://github.com/LOOFTInc)
