<%@ Page Title="Historial de Pedidos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="CampusStoreWeb.OrderHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Estilos específicos para Order History */
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

        .order-table {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .order-table-header {
            padding: 20px 24px;
            border-bottom: 1px solid #E4E7E9;
        }

        .order-table-header h4 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
        }

        .table-custom {
            margin: 0;
        }

        .table-custom thead {
            background-color: #F2F4F5;
        }

        .table-custom thead th {
            padding: 16px 24px;
            font-size: 12px;
            font-weight: 600;
            color: #475156;
            text-transform: uppercase;
            border-bottom: 1px solid #E4E7E9;
        }

        .table-custom tbody td {
            padding: 20px 24px;
            vertical-align: middle;
            border-bottom: 1px solid #E4E7E9;
            color: #191C1F;
        }

        .status-badge {
            padding: 4px 12px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .status-in-progress {
            background-color: #FFF3E6;
            color: #FA8232;
        }

        .status-completed {
            background-color: #E6F9F0;
            color: #2DB224;
        }

        .status-canceled {
            background-color: #FFE6E6;
            color: #EE5858;
        }

        .btn-view-details {
            color: #2DA5F3;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-view-details:hover {
            color: #1e7db8;
            text-decoration: underline;
        }

        .pagination-custom {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 30px;
        }

        .pagination-custom .page-link {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #E4E7E9;
            border-radius: 4px;
            color: #475156;
            text-decoration: none;
            transition: all 0.2s;
        }

        .pagination-custom .page-link:hover {
            background-color: #f8f9fa;
            border-color: #2DA5F3;
        }

        .pagination-custom .page-link.active {
            background-color: #FA8232;
            color: white;
            border-color: #FA8232;
        }

        .pagination-custom .page-arrow {
            background-color: #FA8232;
            color: white;
            border-color: #FA8232;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Default.aspx"><i class="bi bi-house-door"></i> Inicio</a></li>
            <li class="breadcrumb-item"><a href="Settings.aspx">Cuenta de Usuario</a></li>
            <li class="breadcrumb-item active" aria-current="page">Historial de Pedidos</li>
        </ol>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar Menu -->
            <aside class="col-md-3 mb-4">
                <div class="sidebar-menu">
                    <a href="OrderHistory.aspx" class="sidebar-menu-item active">
                        <i class="bi bi-box-seam"></i>
                        Historial de Pedidos
                    </a>
                    <a href="Shopping_Car.aspx" class="sidebar-menu-item">
                        <i class="bi bi-cart3"></i>
                        Carrito de Compras
                    </a>
                    <a href="Settings.aspx" class="sidebar-menu-item">
                        <i class="bi bi-gear"></i>
                        Configuración
                    </a>
                    <a href="LogOut.aspx" class="sidebar-menu-item">
                        <i class="bi bi-box-arrow-right"></i>
                        Cerrar Sesión
                    </a>
                </div>
            </aside>

            <!-- Main Content -->
            <main class="col-md-9">
                <div class="order-table">
                    <div class="order-table-header">
                        <h4>HISTORIAL DE PEDIDOS</h4>
                    </div>

                    <table class="table table-custom">
                        <thead>
                            <tr>
                                <th>ID PEDIDO</th>
                                <th>ESTADO</th>
                                <th>FECHA</th>
                                <th>TOTAL</th>
                                <th>ACCIÓN</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptOrders" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td><strong><%# Eval("OrderId") %></strong></td>
                                        <td>
                                            <span class='status-badge <%# GetStatusClass((string)Eval("Status")) %>'>
                                                <%# Eval("Status") %>
                                            </span>
                                        </td>
                                        <td><%# Eval("OrderDateFormatted") %></td>
                                        <td><strong><%# Eval("TotalFormatted") %></strong></td>
                                        <td>
                                            <a href='OrderDetails.aspx?id=<%# ((OrderInfo)Container.DataItem).OrderId.Replace("#", "") %>' class="btn-view-details">
                                                Ver Detalles <i class="bi bi-arrow-right"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                
            </main>
        </div>
    </div>
</asp:Content>

