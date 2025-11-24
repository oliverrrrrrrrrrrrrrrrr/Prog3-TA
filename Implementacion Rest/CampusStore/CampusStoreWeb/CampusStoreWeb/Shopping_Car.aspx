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
                        <div class="header-product">PRODUCTOS</div>
                        <div class="header-price">PRECIO</div>
                        <div class="header-quantity">CANTIDAD</div>
                        <div class="header-subtotal">SUB-TOTAL</div>
                    </div>

                     <!-- Repeater para los items del carrito -->
        <asp:Repeater ID="rptCartItems" runat="server" OnItemCommand="rptCartItems_ItemCommand">
            <ItemTemplate>
                <div class="cart-item">
                    <!-- Columna de Producto -->
                    <div class="cart-product">
                        <asp:LinkButton runat="server" 
                                        CommandName="Eliminar" 
                                        CommandArgument='<%# Eval("idLineaCarrito") %>'
                                        CssClass="remove-item"
                                        OnClientClick="return confirm('¿Eliminar este producto del carrito?');">
                            &times;
                        </asp:LinkButton>
                        <img src='<%# Eval("producto.imagenURL") %>' alt='<%# Eval("producto.nombre") %>' />
                        <div class="product-info">
                            <span class="product-title"><%# Eval("producto.nombre") %></span>
                        </div>
                    </div>
                    
                    <!-- Columna de Precio -->
                    <div class="cart-price" data-title="Precio">
                        <%# Convert.ToDouble(Eval("precioConDescuento")) > 0 && Convert.ToDouble(Eval("precioConDescuento")) < Convert.ToDouble(Eval("producto.precio")) 
                            ? "<span class='old-price'>S/." + String.Format("{0:N2}", Eval("producto.precio")) + "</span><span class='current-price'>$" + String.Format("{0:N2}", Eval("precioConDescuento")) + "</span>"
                            : "<span class='current-price'>S/." + String.Format("{0:N2}", Eval("precioUnitario")) + "</span>" %>
                    </div>

                    <!-- Columna de Cantidad -->
                    <div class="cart-quantity" data-title="Cantidad">
                        <div class="quantity-selector">
                            <button type="button" 
                                    class="btn-qty btn-qty-minus" 
                                    onclick="cambiarCantidad(this, -1, '<%# Eval("idLineaCarrito") %>')">
                                -
                            </button>
                            <input type="text" 
                                   value='<%# Eval("cantidad") %>' 
                                   class="cantidad-input" 
                                   data-id='<%# Eval("idLineaCarrito") %>'
                                   readonly />
                            <button type="button" 
                                    class="btn-qty btn-qty-plus" 
                                    onclick="cambiarCantidad(this, 1, '<%# Eval("idLineaCarrito") %>')">
                                +
                            </button>

                            <!-- HIDDENFIELDS AQUÍ (dentro del quantity-selector) -->
                            <asp:HiddenField ID="hdnCantidad" runat="server" Value='<%# Eval("cantidad") %>' />
                            <asp:HiddenField ID="hdnIdLinea" runat="server" Value='<%# Eval("idLineaCarrito") %>' />
                        </div>
                    </div>
                    
                    <!-- Columna de Subtotal -->
                    <div class="cart-subtotal" data-title="Sub-Total">
                        $<%# String.Format("{0:N2}", 
                            (Convert.ToDouble(Eval("precioConDescuento")) > 0 
                                ? Convert.ToDouble(Eval("precioConDescuento")) 
                                : Convert.ToDouble(Eval("precioUnitario"))) 
                            * Convert.ToInt32(Eval("cantidad"))) %>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

                    <!-- Botones de Acción Debajo del Carrito -->
                    <div class="cart-actions">
                        <a href="Shop_Page.aspx" class="btn btn-outline-primary"><i class="arrow-left"></i> REGRESAR A LA TIENDA</a>
                        <asp:Button ID="btnGuardarCantidad" runat="server" 
                            Text="ACTUALIZAR CARRITO" 
                            OnClick="btnActualizarCarrito_Click"
                            CssClass="btn btn-outline-primary" />
                    </div>
                </div>
            </div>

            <!-- Columna Derecha: Resumen y Cupón -->
            <div class="col-lg-4">
                <!-- Caja de Resumen -->
                    <asp:Panel ID="pnlResumen" runat="server" CssClass="summary-box">
                        <h3>Resumen de la compra</h3>
        
                        <div class="summary-item">
                            <span>Sub-total</span>
                            <span>S/.<asp:Label ID="lblSubtotal" runat="server" Text="0.00"></asp:Label></span>
                        </div>
        
                        <asp:Panel ID="pnlDescuento" runat="server" Visible="false" CssClass="summary-item">
                            <span>Descuento</span>
                            <span class="discount-amount">-S/.<asp:Label ID="lblDescuento" runat="server" Text="0.00"></asp:Label></span>
                        </asp:Panel>
        
                        <div class="summary-item">
                            <span>Impuesto (18%)</span>
                            <span>S/.<asp:Label ID="lblImpuesto" runat="server" Text="0.00"></asp:Label></span>
                        </div>
        
                        <div class="summary-total">
                            <span>Total</span>
                            <span>S/.<asp:Label ID="lblTotal" runat="server" Text="0.00"></asp:Label></span>
                        </div>
        
                        <asp:HyperLink ID="lnkCheckout" runat="server" NavigateUrl="~/Checkout.aspx" CssClass="btn btn-proceed">
                            PROCEDER AL PAGO <i class="bi bi-arrow-right"></i>
                        </asp:HyperLink>
                    </asp:Panel>

                    <!-- Mensaje si el carrito está vacío -->
                    <asp:Panel ID="pnlResumenVacio" runat="server" Visible="false" CssClass="summary-box summary-empty">
                        <i class="bi bi-cart-x"></i>
                        <p>No hay productos en el carrito</p>
                        <asp:HyperLink runat="server" NavigateUrl="~/Catalogo.aspx" CssClass="btn btn-primary">
                            Ir a comprar
                        </asp:HyperLink>
                    </asp:Panel>
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
    <script>
        function cambiarCantidad(btn, cambio) {
            const container = btn.parentElement;
            const input = container.querySelector('.cantidad-input');
            const hdnCantidad = container.querySelector('input[id*="hdnCantidad"]');

            let nueva = Math.max(1, parseInt(input.value) + cambio);

            console.log('Cambio:', cambio, 'Nueva cantidad:', nueva); // DEBUG

            input.value = nueva;
            if (hdnCantidad) {
                hdnCantidad.value = nueva;
                console.log('HiddenField actualizado:', hdnCantidad.value);
            } else {
                console.error('No se encontró hdnCantidad');
            }
        }
</script>

</asp:Content>
