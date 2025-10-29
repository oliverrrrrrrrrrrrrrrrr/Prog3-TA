<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="CampusStoreWeb.Checkout" %>

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

        .products-header {
            padding: 20px 24px;
            border-bottom: 1px solid #E4E7E9;
        }

        .products-header h5 {
            margin: 0;
            font-size: 16px;
            font-weight: 600;
            color: #191C1F;
        }

        .product-count {
            color: #475156;
            font-weight: 400;
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Shop_Page.aspx"><i class="bi bi-house-door"></i> Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Order Detail Buyout</li>
        </ol>
    </nav>

    <div class="checkout-container">
        <div class="row">
            <!-- Left Column - Order Details -->
            <div class="col-lg-7 mb-4">
                <div class="order-details-container">
                    <!-- Header -->
                    <div class="order-details-header">
                        <a href="Shopping_Car.aspx" class="back-button">
                            <i class="bi bi-arrow-left"></i>
                        </a>
                        <h4>ORDER DETAILS</h4>
                    </div>

                    <!-- Order Summary -->
                    <div class="order-summary">
                        <div class="order-summary-left">
                            <div class="order-id">
                                <asp:Label ID="lblOrderId" runat="server" Text="#96459761"></asp:Label>
                            </div>
                            <div class="order-info">
                                <asp:Label ID="lblProductCount" runat="server" Text="2 Products"></asp:Label>
                                <span> • </span>
                                Order Placed in 
                                <asp:Label ID="lblOrderDate" runat="server" Text="17 Jan, 2021 at 7:32 PM"></asp:Label>
                            </div>
                        </div>
                        <div class="order-summary-right">
                            <div class="order-total">
                                <asp:Label ID="lblOrderTotal" runat="server" Text="$109.00"></asp:Label>
                            </div>
                        </div>
                    </div>

                    <!-- Products Header -->
                    <div class="products-header">
                        <h5>Product <span class="product-count">(<asp:Label ID="lblProductCountHeader" runat="server" Text="02"></asp:Label>)</span></h5>
                    </div>

                    <!-- Products Table -->
                    <table class="table table-custom">
                        <thead>
                            <tr>
                                <th>PRODUCTS</th>
                                <th>PRICE</th>
                                <th>QUANTITY</th>
                                <th>SUB-TOTAL</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptProducts" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <div class="product-info">
                                                <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("ProductName") %>' class="product-image" />
                                                <div class="product-details">
                                                    <span class="product-category"><%# Eval("Category") %></span>
                                                    <span class="product-name"><%# Eval("ProductName") %></span>
                                                </div>
                                            </div>
                                        </td>
                                        <td><strong>$<%# Eval("Price") %></strong></td>
                                        <td>x<%# Eval("Quantity") %></td>
                                        <td><strong>$<%# Eval("SubTotal") %></strong></td>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Right Column - QR Code and Payment -->
            <div class="col-lg-5 mb-4">
                <div class="qr-payment-section">
                    <div class="qr-code-container">
                        <div id="qrcode"></div>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
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
    </script>
</asp:Content>

