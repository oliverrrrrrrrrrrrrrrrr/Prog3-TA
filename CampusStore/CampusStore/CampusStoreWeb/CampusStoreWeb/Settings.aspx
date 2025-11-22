<%@ Page Title="Settings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="CampusStoreWeb.Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
    .custom-alert {
        display: none;
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 20px;
        background-color: #f44336;
        color: white;
        border-radius: 5px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.2);
        z-index: 9999;
        animation: slideIn 0.3s ease-out;
    }
    @keyframes slideIn {
        from { transform: translateX(400px); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }
    </style>

    <script>
    function showCustomAlert(message) {
        var alert = document.getElementById('customAlert');
        alert.textContent = message;
        alert.style.display = 'block';
        setTimeout(function () {
            alert.style.display = 'none';
        }, 4000);
    }
</script>

    <style>
        /* Estilos específicos para Settings */
        .breadcrumb {
            background-color: #f8f9fa;
            padding: 15px 0;
            margin-bottom: 30px;
        }

        .breadcrumb-item + .breadcrumb-item::before {
            content: ">";
            padding: 0 10px;
            color: #6c757d;
        }

        .breadcrumb-item a {
            color: #6c757d;
            text-decoration: none;
        }

        .breadcrumb-item.active {
            color: #2DA5F3;
        }

        .sidebar-menu {
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .sidebar-menu-item {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            border-bottom: 1px solid #E4E7E9;
            text-decoration: none;
            color: #191C1F;
            transition: background-color 0.2s;
        }

        .sidebar-menu-item:last-child {
            border-bottom: none;
        }

        .sidebar-menu-item:hover {
            background-color: #f8f9fa;
        }

        .sidebar-menu-item.active {
            background-color: #FA8232;
            color: white;
        }

        .sidebar-menu-item i {
            margin-right: 12px;
            font-size: 18px;
            width: 24px;
        }

        .settings-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 30px;
        }

        .settings-header {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #E4E7E9;
        }

        .settings-header h4 {
            margin: 0;
            font-size: 24px;
            font-weight: 600;
            color: #191C1F;
        }

        .settings-section {
            margin-bottom: 30px;
        }

        .settings-section-title {
            font-size: 18px;
            font-weight: 600;
            color: #191C1F;
            margin-bottom: 20px;
        }

        .form-group-custom {
            margin-bottom: 20px;
        }

        .form-group-custom label {
            display: block;
            font-weight: 500;
            color: #475156;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .form-group-custom .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #E4E7E9;
            border-radius: 4px;
            font-size: 14px;
            color: #191C1F;
        }

        .form-group-custom .form-control:focus {
            outline: none;
            border-color: #FA8232;
            box-shadow: 0 0 0 0.2rem rgba(250, 130, 50, 0.25);
        }

        .btn-save-changes {
            background-color: #FA8232;
            color: white;
            padding: 12px 40px;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-save-changes:hover {
            background-color: #e67528;
        }

        .btn-cancel {
            background-color: transparent;
            color: #475156;
            padding: 12px 40px;
            border: 2px solid #E4E7E9;
            border-radius: 4px;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.2s;
            margin-left: 15px;
        }

        .btn-cancel:hover {
            border-color: #FA8232;
            color: #FA8232;
        }

        .alert-success-custom {
            background-color: #E6F9F0;
            color: #2DB224;
            padding: 15px 20px;
            border-radius: 4px;
            margin-bottom: 20px;
            display: none;
        }

        .form-row-custom {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        @media (max-width: 768px) {
            .form-row-custom {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Shop_Page.aspx"><i class="bi bi-house-door"></i>Home</a></li>
            <li class="breadcrumb-item"><a href="Settings.aspx">Cuenta de Usuario</a></li>
            <li class="breadcrumb-item active" aria-current="page">Configuración</li>
        </ol>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar Menu -->
            <aside class="col-md-3 mb-4">
                <div class="sidebar-menu">
                    <a href="OrderHistory.aspx" class="sidebar-menu-item">
                        <i class="bi bi-box-seam"></i>
                        Historial de compras
                    </a>
                    <a href="Shopping_Car.aspx" class="sidebar-menu-item">
                        <i class="bi bi-cart3"></i>
                        Carrito de compras
                    </a>
                    <a href="Settings.aspx" class="sidebar-menu-item active">
                        <i class="bi bi-gear"></i>
                        Configuración de la cuenta
                    </a>
                    <a href="LogOut.aspx" class="sidebar-menu-item">
                        <i class="bi bi-box-arrow-right"></i>
                        Cerrar sesión
                    </a>
                </div>
            </aside>

            <!-- Main Content -->
            <main class="col-md-9">
                <div class="settings-container">
                    <div class="settings-header">
                        <h4>CONFIGURACIÓN DE LA CUENTA</h4>
                    </div>

                    <!-- Mensaje de éxito -->
                    <div id="alertSuccess" class="alert-success-custom">
                        <i class="bi bi-check-circle"></i> ¡Los cambios se han guardado correctamente!
                    </div>

                    <div id="customAlert" class="custom-alert"></div>

                    <!-- Sección de Información de Cuenta -->
                    <div class="settings-section">
                        <div class="form-row-custom">
                            <div class="form-group-custom">
                                <label for="txtUsername">Nombre de Usuario</label>
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
                            </div>
                            
                            <div class="form-group-custom">
                                <label for="txtFullName">Nombre Completo</label>
                                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Full Name"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-row-custom">
                            <div class="form-group-custom">
                                <label for="txtEmail">Correo electrónico</label>
                                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" placeholder="Email"></asp:TextBox>
                            </div>
                        </div>

                        <asp:CustomValidator 
                            ID="cvSignUpError" 
                            runat="server" 
                            Display="Dynamic"
                            CssClass="text-danger small d-block"
                            EnableClientScript="false" />

                        <div class="settings-actions" style="margin-top: 20px;">
                            <asp:Button ID="btnSaveAccountChanges" runat="server" Text="GUARDAR CAMBIOS" CssClass="btn-save-changes" OnClick="btnSaveChanges_Click" />
                        </div>
                    </div>

                    <!-- Sección de Cambio de Contraseña -->
                    <div class="settings-section">
                        <h5 class="settings-section-title">CAMBIAR CONTRASEÑA</h5>
                        
                        <div class="form-group-custom">
                            <label for="txtCurrentPassword">Contraseña actual</label>
                            <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="form-group-custom">
                            <label for="txtNewPassword">Nueva contraseña</label>
                            <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                        </div>
                        
                        <div class="form-group-custom">
                            <label for="txtConfirmPassword">Confirmar nueva contraseña</label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="settings-actions" style="margin-top: 20px;">
                            <asp:Button ID="btnChangePassword" runat="server" Text="CAMBIAR CONTRASEÑA" CssClass="btn-save-changes" OnClick="btnChangePassword_Click" />
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        function resetForm() {
            if (confirm('¿Seguro que deseas descartar los cambios?')) {
                location.reload();
            }
        }

        function showSuccessMessage() {
            const alert = document.getElementById('alertSuccess');
            alert.style.display = 'block';
            setTimeout(() => {
                alert.style.display = 'none';
            }, 3000);
        }
    </script>
</asp:Content>

