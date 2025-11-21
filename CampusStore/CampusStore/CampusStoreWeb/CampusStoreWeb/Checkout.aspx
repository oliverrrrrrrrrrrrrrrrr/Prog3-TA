<%@ Page Title="Finalizar Compra" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="CampusStoreWeb.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Estilos específicos para Checkout */
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

        .checkout-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .order-details-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .order-details-header {
            padding: 20px 24px;
            border-bottom: 1px solid #E4E7E9;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .back-button {
            background: none;
            border: none;
            font-size: 20px;
            color: #475156;
            cursor: pointer;
            padding: 0;
            display: flex;
            align-items: center;
            text-decoration: none;
        }

        .back-button:hover {
            color: #191C1F;
        }

        .order-details-header h4 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
        }

        .order-summary {
            background-color: #FFF9E6;
            padding: 20px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .order-summary-left {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .order-id {
            font-size: 20px;
            font-weight: 600;
            color: #191C1F;
        }

        .order-info {
            font-size: 14px;
            color: #475156;
        }

        .order-total {
            font-size: 28px;
            font-weight: 700;
            color: #2DA5F3;
        }

        .checkout-products {
            padding: 0;
        }

        .products-title {
            padding: 20px 24px;
            border-bottom: 1px solid #E4E7E9;
        }

        .products-title h5 {
            margin: 0;
            font-size: 16px;
            font-weight: 600;
            color: #191C1F;
        }

        .product-count {
            color: #475156;
            font-weight: 400;
        }

        .products-header {
            display: grid;
            grid-template-columns: 2fr 100px 120px 120px;
            gap: 16px;
            padding: 16px 24px;
            background-color: #F2F4F5;
            border-bottom: 1px solid #E4E7E9;
            font-size: 12px;
            font-weight: 600;
            color: #475156;
            text-transform: uppercase;
        }

        .header-producto {
            grid-column: 1;
        }

        .header-cantidad {
            grid-column: 2;
            text-align: center;
        }

        .header-precio {
            grid-column: 3;
            text-align: right;
        }

        .header-subtotal {
            grid-column: 4;
            text-align: right;
        }

        .product-row {
            display: grid;
            grid-template-columns: 2fr 100px 120px 120px;
            gap: 16px;
            padding: 20px 24px;
            border-bottom: 1px solid #E4E7E9;
            align-items: center;
        }

        .product-row:last-child {
            border-bottom: none;
        }

        .product-row .product-info {
            grid-column: 1;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .product-row .product-info img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border: 1px solid #E4E7E9;
            border-radius: 4px;
        }

        .product-row .product-info .product-name {
            font-size: 14px;
            color: #191C1F;
            font-weight: 500;
        }

        .product-row .product-quantity {
            grid-column: 2;
            text-align: center;
            font-size: 14px;
            color: #191C1F;
        }

        .product-row .product-price {
            grid-column: 3;
            text-align: right;
            font-size: 14px;
            color: #191C1F;
            font-weight: 500;
        }

        .product-row .product-subtotal {
            grid-column: 4;
            text-align: right;
            font-size: 14px;
            color: #191C1F;
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

        .product-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border: 1px solid #E4E7E9;
            border-radius: 4px;
        }

        .product-details {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .product-category {
            font-size: 12px;
            color: #2DA5F3;
            text-transform: uppercase;
            font-weight: 600;
        }

        .product-name {
            font-size: 14px;
            color: #191C1F;
            font-weight: 500;
        }

        .btn-rating {
            color: #FA8232;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-rating:hover {
            color: #e67528;
            text-decoration: underline;
        }

        /* QR Code Section */
        .qr-payment-section {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 40px;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 30px;
        }

        .qr-code-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            display: inline-block;
        }

        #qrcode {
            display: inline-block;
        }

        .btn-proceed-payment {
            background-color: #FA8232;
            color: white;
            border: none;
            padding: 16px 40px;
            font-size: 16px;
            font-weight: 700;
            text-transform: uppercase;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }

        .btn-proceed-payment:hover {
            background-color: #e67528;
            color: white;
        }

        .payment-instructions {
            font-size: 14px;
            color: #475156;
            line-height: 1.6;
            max-width: 400px;
        }

        .payment-instructions strong {
            color: #191C1F;
        }

        @media (max-width: 768px) {
            .order-summary {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .qr-payment-section {
                padding: 20px;
            }
        }
        .order-details {
            background: white;
            border: 1px solid #E4E7E9;
            border-radius: 4px;
            overflow: hidden;
        }

        .order-header {
            display: grid;
            grid-template-columns: 80px 2fr 100px 120px 120px;
            gap: 16px;
            padding: 16px;
            background: #F2F4F5;
            font-weight: 600;
            font-size: 12px;
            color: #475156;
            text-transform: uppercase;
        }

        .order-header div:first-child {
            grid-column: 1 / 3;
        }

        .order-header div:nth-child(3),
        .order-header div:nth-child(4),
        .order-header div:nth-child(5) {
            text-align: right;
        }

        /* Estilos para mensajes de alerta */
        .alert-message {
            padding: 16px 20px;
            border-radius: 8px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 14px;
            font-weight: 500;
        }

        .alert-success {
            background-color: #D4EDDA;
            color: #155724;
            border: 1px solid #C3E6CB;
        }

        .alert-info {
            background-color: #D1ECF1;
            color: #0C5460;
            border: 1px solid #BEE5EB;
        }

        .alert-warning {
            background-color: #FFF3CD;
            color: #856404;
            border: 1px solid #FFEAA7;
        }

        .alert-danger {
            background-color: #F8D7DA;
            color: #721C24;
            border: 1px solid #F5C6CB;
        }

        .alert-message i {
            font-size: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Shop_Page.aspx"><i class="bi bi-house-door"></i> Inicio</a></li>
            <li class="breadcrumb-item active" aria-current="page">Detalle del Pedido</li>
        </ol>
    </nav>

    <div class="checkout-container">
    <div class="row">
        <!-- Left Column - Order Details -->
        <div class="col-lg-7 mb-4">
            <div class="order-details-container">
                <!-- Mensaje de alerta -->
                <asp:Panel ID="pnlMensaje" runat="server" CssClass="alert-message" Visible="false">
                    <asp:Label ID="iconMensaje" runat="server" CssClass="bi"></asp:Label>
                    <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                </asp:Panel>

                <!-- Header -->
                <div class="order-details-header">
                    <a href="Shopping_Car.aspx" class="back-button">
                        <i class="bi bi-arrow-left"></i>
                    </a>
                    <h4>DETALLES DEL PEDIDO</h4>
                </div>

                <!-- Order Summary -->
                <div class="order-summary">
                    <div class="order-summary-left">
                        <div class="order-id">
                            <asp:Label ID="lblOrderId" runat="server"></asp:Label>
                        </div>
                        <div class="order-info">
                            <asp:Label ID="lblProductCount" runat="server"></asp:Label>
                            <span> • </span>
                            Pedido realizado el 
                            <asp:Label ID="lblOrderDate" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="order-summary-right">
                        <div class="order-total">
                            $<asp:Label ID="lblOrderTotal" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- Products Section -->
                <div class="checkout-products">
                    <!-- Título de productos -->
                    <div class="products-title">
                        <h5>Productos (<asp:Label ID="lblProductCountHeader" runat="server"></asp:Label>)</h5>
                    </div>

                    <!-- Header de la tabla -->
                    <div class="products-header">
                        <div class="header-producto">PRODUCTO</div>
                        <div class="header-cantidad">CANTIDAD</div>
                        <div class="header-precio">PRECIO</div>
                        <div class="header-subtotal">SUBTOTAL</div>
                    </div>

                    <!-- Repeater con los productos -->
                    <asp:Repeater ID="rptDetalleOrden" runat="server">
                        <ItemTemplate>
                            <div class="product-row">
                                <!-- Columna Producto (imagen + nombre) -->
                                <div class="product-info">
                                    <img src='<%# Eval("producto.imagenURL") %>' alt='<%# Eval("producto.nombre") %>' />
                                    <span class="product-name"><%# Eval("producto.nombre") %></span>
                                </div>
                
                                <!-- Columna Cantidad -->
                                <div class="product-quantity">
                                    x<%# Eval("cantidad") %>
                                </div>
                
                                <!-- Columna Precio -->
                                <div class="product-price">
                                    $<%# String.Format("{0:N2}", 
                                        Convert.ToDouble(Eval("precioConDescuento")) > 0 
                                            ? Eval("precioConDescuento") 
                                            : Eval("precioUnitario")) %>
                                </div>
                
                                <!-- Columna Subtotal -->
                                <div class="product-subtotal">
                                    $<%# String.Format("{0:N2}", 
                                        (Convert.ToDouble(Eval("precioConDescuento")) > 0 
                                            ? Convert.ToDouble(Eval("precioConDescuento")) 
                                            : Convert.ToDouble(Eval("precioUnitario"))) 
                                        * Convert.ToInt32(Eval("cantidad"))) %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>

        <!-- Right Column - QR Code and Payment -->
        <div class="col-lg-5 mb-4">
            <div class="qr-payment-section">
                <div class="qr-code-container">
                    <asp:Image ID="imgQr" runat="server" />
                </div>

                <asp:LinkButton ID="btnProceedPayment" runat="server" CssClass="btn-proceed-payment" OnClick="btnProceedPayment_Click">
                    PROCEDER CON EL PAGO DIFERIDO <i class="bi bi-arrow-right"></i>
                </asp:LinkButton>

                <div class="payment-instructions">
                    Lea este QR o presione el botón para realizar el pago diferido.
                    <br /><br />
                    <strong>Tiene 48 horas para realizar el pago, caso contrario su orden será cancelada.</strong>
                </div>
            </div>
        </div>
    </div>
</div>

    
    <!-- QR Code Library -->
    <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
            // Generar el código QR
            var qrcode = new QRCode(document.getElementById("qrcode"), {
                text: "https://campusstore.com/payment/<%= lblOrderId.Text %>",
                width: 300,
                height: 300,
                colorDark: "#00b300",
                colorLight: "#ffffff",
                correctLevel: QRCode.CorrectLevel.H
            });
        });
    </script> -->
</asp:Content>

