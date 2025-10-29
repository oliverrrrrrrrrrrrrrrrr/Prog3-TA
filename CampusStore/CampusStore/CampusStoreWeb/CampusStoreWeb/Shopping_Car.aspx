<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Shopping_Car.aspx.cs" Inherits="CampusStoreWeb.Shopping_Car" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* ================================================= */
/*          CSS PARA PÁGINA DE CARRITO DE COMPRAS    */
/* ================================================= */
.cart-page {
    background-color: #f8f9fa; /* Un fondo ligeramente gris */
}

/* --- Contenedor principal de la tabla --- */
.cart-table-container {
    background-color: #fff;
    padding: 2rem;
    border: 1px solid #e9ecef;
    border-radius: 4px;
}

/* --- Encabezados de la tabla --- */
.cart-header {
    display: flex;
    background-color: #f8f9fa;
    padding: 0.75rem 1.5rem;
    color: #6c757d;
    font-size: 0.8rem;
    font-weight: 600;
    text-transform: uppercase;
    border-bottom: 1px solid #e9ecef;
}
.header-product { flex: 3; }
.header-price, .header-quantity, .header-subtotal { flex: 1; text-align: center; }

/* --- Fila de cada item --- */
.cart-item {
    display: flex;
    align-items: center;
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
}
.cart-product { flex: 3; display: flex; align-items: center; }
.cart-price, .cart-quantity, .cart-subtotal { flex: 1; text-align: center; font-weight: 600; }

.cart-item img {
    width: 80px;
    height: 80px;
    object-fit: cover;
    margin-right: 1.5rem;
    border: 1px solid #e9ecef;
}

.product-title {
    font-weight: 600;
    color: #212529;
    text-decoration: none;
}
.product-title:hover { color: #0d6efd; }

.old-price { text-decoration: line-through; color: #adb5bd; margin-right: 0.5rem; }
.current-price { color: #212529; }

.remove-item {
    background-color: #fff;
    border: 1px solid #ced4da;
    color: #dc3545;
    width: 24px;
    height: 24px;
    border-radius: 50%;
    line-height: 22px;
    text-align: center;
    margin-right: 1rem;
    cursor: pointer;
    font-size: 1.2rem;
}

/* --- Selector de Cantidad --- */
.quantity-selector {
    display: flex;
    justify-content: center;
    align-items: center;
    border: 1px solid #ced4da;
    width: 120px;
    margin: 0 auto; /* Centrarlo */
}
.quantity-selector input {
    width: 50px;
    text-align: center;
    border: none;
    font-weight: 700;
}
.quantity-selector .btn-qty {
    background: none;
    border: none;
    font-size: 1.5rem;
    color: #6c757d;
    padding: 0 10px;
}

/* --- Botones de acción (debajo de la tabla) --- */
.cart-actions {
    display: flex;
    justify-content: space-between;
    padding-top: 2rem;
}
.cart-actions .btn { font-weight: 600; text-transform: uppercase; font-size: 0.9rem; }
.arrow-left::before { content: '← '; }
.arrow-right::after { content: ' →'; }

/* --- Columna Derecha: Resumen y Cupón --- */
.summary-box, .coupon-box {
    background-color: #fff;
    padding: 1.5rem;
    border: 1px solid #e9ecef;
    border-radius: 4px;
    margin-bottom: 1.5rem;
}
.summary-box h3, .coupon-box h3 { font-size: 1.2rem; font-weight: 600; margin-bottom: 1.5rem; }

.summary-item, .summary-total {
    display: flex;
    justify-content: space-between;
    margin-bottom: 1rem;
    color: #6c757d;
}
.summary-total {
    font-weight: 700;
    color: #212529;
    font-size: 1.2rem;
    border-top: 1px solid #e9ecef;
    padding-top: 1rem;
}

.btn-proceed {
    background-color: #f7772b;
    color: #fff;
    text-align: center;
    display: block;
    width: 100%;
    padding: 0.8rem;
    text-decoration: none;
    font-weight: 700;
    border-radius: 4px;
    transition: background-color 0.2s;
}
.btn-proceed:hover { background-color: #e06014; color: #fff; }

.btn-apply-coupon {
    background-color: #0dcaf0;
    color: #fff;
    text-align: center;
    display: block;
    width: 100%;
    padding: 0.8rem;
    text-decoration: none;
    font-weight: 700;
    border-radius: 4px;
    margin-top: 1rem;
    transition: background-color 0.2s;
}
.btn-apply-coupon:hover { background-color: #0ba9c9; color: #fff; }
    </style>
    <div class="cart-page py-5">
    <div class="container">
        <div class="row">
            <!-- Columna Izquierda: Lista de Productos -->
            <div class="col-lg-8 mb-4">
                <div class="cart-table-container">
                    <h2 class="mb-4">Carrito</h2>
                    
                    <!-- Encabezados de la tabla -->
                    <div class="cart-header d-none d-md-flex">
                        <div class="header-product">PRODUCTS</div>
                        <div class="header-price">PRICE</div>
                        <div class="header-quantity">QUANTITY</div>
                        <div class="header-subtotal">SUB-TOTAL</div>
                    </div>

                    <!-- Repeater para los items del carrito -->
                    <asp:Repeater ID="rptCartItems" runat="server">
                        <ItemTemplate>
                            <div class="cart-item">
                                <!-- Columna de Producto -->
                                <div class="cart-product">
                                    <button class="remove-item">&times;</button>
                                    <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("Title") %>' />
                                    <div class="product-info">
                                        <a href="#" class="product-title"><%# Eval("Title") %></a>
                                    </div>
                                </div>
                                <!-- Columna de Precio -->
                                <div class="cart-price" data-title="Price">
                                    <span class="old-price"><%# Eval("OldPrice", "${0:0.00}") %></span>
                                    <span class="current-price"><%# Eval("CurrentPrice", "${0:0.00}") %></span>
                                </div>
                                <!-- Columna de Cantidad -->
                                <div class="cart-quantity" data-title="Quantity">
                                    <div class="quantity-selector">
                                        <button type="button" class="btn-qty btn-qty-minus">-</button>
                                        <input type="text" value='<%# Eval("Quantity") %>' readonly />
                                        <button type="button" class="btn-qty btn-qty-plus">+</button>
                                    </div>
                                </div>
                                <!-- Columna de Subtotal -->
                                <div class="cart-subtotal" data-title="Sub-Total">
                                    <%# Eval("SubTotal", "${0:0.00}") %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <!-- Botones de Acción Debajo del Carrito -->
                    <div class="cart-actions">
                        <a href="Shop_Page.aspx" class="btn btn-outline-primary"><i class="arrow-left"></i> REGRESAR A LA TIENDA</a>
                        <a href="#" class="btn btn-outline-primary">ACTUALIZAR CARRITO</a>
                    </div>
                </div>
            </div>

            <!-- Columna Derecha: Resumen y Cupón -->
            <div class="col-lg-4">
                <!-- Caja de Resumen -->
                <div class="summary-box">
                    <h3>Resumen de la compra</h3>
                    <div class="summary-item">
                        <span>Sub-total</span>
                        <span>$95.00</span>
                    </div>
                    <div class="summary-item">
                        <span>Shipping</span>
                        <span>Free</span>
                    </div>
                    <div class="summary-item">
                        <span>Discount</span>
                        <span>$29.00</span>
                    </div>
                     <div class="summary-item">
                        <span>Tax</span>
                        <span>$17.10</span>
                    </div>
                    <div class="summary-total">
                        <span>Total</span>
                        <span>$112.10 USD</span>
                    </div>
                    <a href="Checkout.aspx" class="btn btn-proceed">PROCEED TO CHECKOUT <i class="arrow-right"></i></a>
                </div>

                <!-- Caja de Cupón -->
                <div class="coupon-box">
                    <h3>Código del cupón</h3>
                    <input type="text" class="form-control" placeholder="Ingrese el código del cupón" />
                    <a href="#" class="btn btn-apply-coupon">APLICAR CUPÓN</a>
                </div>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        // Seleccionamos todos los contenedores de cantidad que hay en la página
        const quantitySelectors = document.querySelectorAll('.quantity-selector');

        // Recorremos cada uno de ellos para asignarles los eventos
        quantitySelectors.forEach(selector => {
            const minusButton = selector.querySelector('.btn-qty-minus');
            const plusButton = selector.querySelector('.btn-qty-plus');
            const inputField = selector.querySelector('input[type="text"]');

            // Evento para el botón de restar (-)
            minusButton.addEventListener('click', function() {
                // Obtenemos el valor actual y lo convertimos a número
                let currentValue = parseInt(inputField.value, 10);

                // Solo restamos si el valor es mayor que 1
                if (currentValue > 1) {
                    inputField.value = currentValue - 1;
                }
            });

            // Evento para el botón de sumar (+)
            plusButton.addEventListener('click', function() {
                // Obtenemos el valor actual y lo convertimos a número
                let currentValue = parseInt(inputField.value, 10);

                // Sumamos 1 al valor actual
                inputField.value = currentValue + 1;
            });
        });
    });
    </script>

</asp:Content>
