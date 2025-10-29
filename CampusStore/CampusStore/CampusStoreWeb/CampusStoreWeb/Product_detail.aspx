<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Product_detail.aspx.cs" Inherits="CampusStoreWeb.Product_detail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .product-detail-page-v2 {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
    color: #4a4a4a;
}

    /* --- Breadcrumb (Migas de Pan) --- */
    .product-detail-page-v2 .breadcrumb {
        font-size: 0.9rem;
        padding-left: 0;
        margin-bottom: 1.5rem;
    }

    .product-detail-page-v2 .breadcrumb-item a {
        color: #007bff;
        text-decoration: none;
    }

    .product-detail-page-v2 .breadcrumb-item.active {
        color: #6c757d;
    }

    /* --- Columna Izquierda: Galería de Imágenes --- */
    .product-detail-page-v2 .main-image img {
        width: 100%;
        border: 1px solid #e0e0e0;
        border-radius: 4px;
    }

    .product-detail-page-v2 .thumbnail-gallery {
        margin-top: 15px;
        position: relative; /* Clave para posicionar las flechas */
        display: flex;
        align-items: center;
    }

    .product-detail-page-v2 .thumbnails-container {
        display: flex;
        gap: 10px;
        overflow-x: auto; /* Permite el scroll horizontal */
        scroll-behavior: smooth;
        -ms-overflow-style: none; /* IE y Edge */
        scrollbar-width: none; /* Firefox */
        padding: 5px; /* Espacio para el borde de la imagen activa */
    }
        /* Ocultar barra de scroll en Chrome, Safari y Opera */
        .product-detail-page-v2 .thumbnails-container::-webkit-scrollbar {
            display: none;
        }

    .product-detail-page-v2 .thumbnail {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border: 2px solid #ddd;
        border-radius: 4px;
        cursor: pointer;
        transition: border-color 0.3s ease;
        flex-shrink: 0; /* Evita que las imágenes se encojan */
    }

        .product-detail-page-v2 .thumbnail:hover,
        .product-detail-page-v2 .thumbnail.active {
            border-color: #ff6600; /* Naranja de la marca */
        }

    .product-detail-page-v2 .gallery-arrow {
        background-color: #ff6600;
        color: white;
        border: none;
        border-radius: 50%;
        width: 35px;
        height: 35px;
        font-size: 1.2rem;
        line-height: 1;
        cursor: pointer;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        position: absolute; /* Posicionamiento sobre el contenedor */
        z-index: 10;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .product-detail-page-v2 .prev-arrow {
        left: -15px;
    }

    .product-detail-page-v2 .next-arrow {
        right: -15px;
    }


    /* --- Columna Derecha: Detalles del Producto --- */
    .product-detail-page-v2 .product-rating {
        margin-bottom: 0.5rem;
        font-size: 0.9rem;
        color: #6c757d;
    }

        .product-detail-page-v2 .product-rating .stars {
            color: #ffc107; /* Amarillo para las estrellas */
            letter-spacing: 1px;
        }

    .product-detail-page-v2 .product-title {
        font-size: 2.2rem;
        font-weight: 600;
        margin-bottom: 1rem;
        color: #212529;
    }

    .product-detail-page-v2 .meta-info {
        font-size: 0.9rem;
        line-height: 1.7;
        margin-bottom: 1.5rem;
        color: #6c757d;
    }

        .product-detail-page-v2 .meta-info strong {
            color: #212529;
            font-weight: 500;
        }

    .product-detail-page-v2 .stock-status.in-stock {
        color: #28a745; /* Verde para In Stock */
        font-weight: 700;
    }

    .product-detail-page-v2 .stock-status.out-stock {
        color: #dc3545; /* Rojo para Out of Stock */
        font-weight: 700;
    }

    .product-detail-page-v2 .product-price-block {
        margin-bottom: 1.5rem;
        display: flex;
        align-items: center;
        flex-wrap: wrap; /* Para que se ajuste en pantallas pequeñas */
        gap: 15px;
    }

    .product-detail-page-v2 .current-price {
        font-size: 2.5rem;
        font-weight: 700;
        color: #0d6efd; /* Azul como en el ejemplo */
    }

    .product-detail-page-v2 .old-price {
        font-size: 1.25rem;
        color: #6c757d;
        text-decoration: line-through;
    }

    .product-detail-page-v2 .discount-badge {
        background-color: #ffc107; /* Amarillo */
        color: #212529;
        font-weight: 700;
        padding: 4px 8px;
        border-radius: 4px;
        font-size: 0.85rem;
    }


    /* --- Bloque de Botones de Acción --- */
    .product-detail-page-v2 .action-buttons-container {
        display: flex;
        align-items: center;
        gap: 10px; /* Espacio entre elementos */
        margin-bottom: 2rem;
    }

    .product-detail-page-v2 .qty-selector {
        display: flex;
        border: 1px solid #ced4da;
        border-radius: 4px;
        height: 48px;
    }

        .product-detail-page-v2 .qty-selector button {
            background-color: #f8f9fa;
            border: none;
            width: 40px;
            font-size: 1.2rem;
            color: #6c757d;
        }

        .product-detail-page-v2 .qty-selector input {
            width: 50px;
            text-align: center;
            border: none;
            border-left: 1px solid #ced4da;
            border-right: 1px solid #ced4da;
            font-weight: 700;
            font-size: 1.1rem;
        }

    .product-detail-page-v2 .btn-orange-solid,
    .product-detail-page-v2 .btn-orange-outline {
        height: 48px;
        padding: 0 25px;
        font-weight: 700;
        font-size: 0.9rem;
        text-transform: uppercase;
        border-radius: 4px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px; /* Espacio para el ícono del carrito */
        transition: all 0.2s ease-in-out;
    }

    .product-detail-page-v2 .btn-orange-solid {
        background-color: #ff6600;
        border: 2px solid #ff6600;
        color: white;
    }

        .product-detail-page-v2 .btn-orange-solid:hover {
            background-color: #e65c00;
            border-color: #e65c00;
            color: white;
        }

    .product-detail-page-v2 .btn-orange-outline {
        background-color: transparent;
        border: 2px solid #ff6600;
        color: #ff6600;
    }

        .product-detail-page-v2 .btn-orange-outline:hover {
            background-color: #ff6600;
            color: white;
        }

    /* --- Sección de Tabs (Descripción, etc.) --- */
    .product-detail-page-v2 .custom-tabs .nav-tabs {
        border-bottom: 2px solid #dee2e6;
    }

    .product-detail-page-v2 .custom-tabs .nav-link {
        color: #6c757d;
        font-weight: 600;
        border: none;
        border-bottom: 3px solid transparent;
        padding: 0.8rem 0;
        margin-right: 2rem;
    }

        .product-detail-page-v2 .custom-tabs .nav-link.active,
        .product-detail-page-v2 .custom-tabs .nav-link:hover {
            color: #212529;
            border-bottom-color: #ff6600;
        }

    .product-detail-page-v2 .tab-content {
        padding: 1.5rem 0;
        line-height: 1.7;
    }
    </style>
<div class="product-detail-page-v2 py-5">
    <div class="container">
        
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
                <li class="breadcrumb-item"><a href="Shop_Page.aspx">Catálogo</a></li>
                <li class="breadcrumb-item active" aria-current="page" id="breadcrumb-title">...</li>
            </ol>
        </nav>

        <div class="row">
            <!-- Columna Izquierda: Imágenes -->
            <div class="col-md-6 mb-4">
                <div class="main-image mb-3">
                    <img id="main-img" src="https://via.placeholder.com/600x400?text=Cargando..." alt="Product Image" class="img-fluid">
                </div>
                <div class="thumbnail-gallery">
                    <button class="gallery-arrow prev-arrow" type="button">&#10094;</button>
                    <div class="thumbnails-container" id="thumbs-container">
                        <!-- Miniaturas generadas por JS -->
                    </div>
                    <button class="gallery-arrow next-arrow" type="button">&#10095;</button>
                </div>
            </div>

            <!-- Columna Derecha: Detalles -->
            <div class="col-md-6">
                <div class="product-rating mb-2" id="rating-block"></div>
                
                <h1 class="product-title" id="product-title">Cargando...</h1>

                <div class="meta-info">
                    <div class="row">
                        <div class="col-6">
                            Sku: <strong id="meta-sku">N/A</strong><br>
                            Autor: <strong id="meta-author">N/A</strong>
                        </div>
                        <div class="col-6">
                            Availability: <span id="meta-stock" class="stock-status">...</span><br>
                            Category: <strong id="meta-category">N/A</strong>
                        </div>
                    </div>
                </div>

                <div class="product-price-block" id="price-block"></div>

                <div class="action-buttons-container">
                    <div class="qty-selector">
                        <button type="button" id="qty-minus">-</button>
                        <input type="text" value="1" id="qty-input" readonly>
                        <button type="button" id="qty-plus">+</button>
                    </div>
                    <button class="btn btn-orange-solid">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cart-fill" viewBox="0 0 16 16"><path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/></svg>
                        ADD TO CART
                    </button>
                    <button class="btn btn-orange-outline">BUY NOW</button>
                </div>
            </div>
        </div>

        <!-- Sección de Tabs -->
        <div class="row mt-5">
            <div class="col-12">
                 <div class="custom-tabs">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                       <li class="nav-item" role="presentation"><button class="nav-link active" data-bs-toggle="tab" data-bs-target="#desc-pane" type="button">DESCRIPTION</button></li>
                       <li class="nav-item" role="presentation"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#info-pane" type="button">ADDITIONAL INFORMATION</button></li>
                       <li class="nav-item" role="presentation"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#spec-pane" type="button">SPECIFICATION</button></li>
                       <li class="nav-item" role="presentation"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#review-pane" type="button">REVIEW</button></li>
                    </ul>
                   <div class="tab-content" id="myTabContent">
                       <div class="tab-pane fade show active" id="desc-pane"><div id="content-desc">...</div></div>
                       <div class="tab-pane fade" id="info-pane"><div id="content-info">...</div></div>
                       <div class="tab-pane fade" id="spec-pane"><div id="content-spec">...</div></div>
                       <div class="tab-pane fade" id="review-pane"><div id="content-review">...</div></div>
                   </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // === MINI BASE DE DATOS ===
        const productosDB = [
            {
                id: 1,
                titulo: "Undertale Art Book",
                autor: "Toby Fox", sku: "A264671", stock: true, categoria: "Libros",
                precioActual: 70.00, precioAntiguo: 90.00, discount: 22,
                imagen: "Images/undertale.png",
                thumbnails: ["Images/undertale.png", "Images/undertale.png", "Images/undertale.png", "Images/undertale.png", "Images/undertale.png"],
                desc: "Un libro de arte oficial que explora el desarrollo visual del aclamado videojuego Undertale.",
                info: "Peso: 1.2kg, Dimensiones: 25x30 cm", spec: "Tapa dura, 228 páginas, Idioma: Inglés", review: "Sin reseñas.",
                rating: 4.7, reviews: 738
            },
            {
                id: 2, titulo: "Modern Operating Systems", autor: "Andrew S. Tanenbaum", sku: "B9981", stock: true, categoria: "Computación",
                precioActual: 2300.00, precioAntiguo: null, discount: 0,
                imagen: "Images/libroSISOPS.webp", thumbnails: ["Images/libroSISOPS.webp", "Images/libroSISOPS.webp"],
                desc: "Texto fundamental en sistemas operativos.", info: "N/A", spec: "N/A", review: "N/A", rating: 5.0, reviews: 536
            },
            {
                id: 3, titulo: "El Libro Troll", autor: "El Rubius", sku: "C7721", stock: false, categoria: "Humor",
                precioActual: 360.00, precioAntiguo: null, discount: 0,
                imagen: "Images/libroTroll.jpg", thumbnails: ["Images/libroTroll.jpg"],
                desc: "Libro interactivo de retos.", info: "N/A", spec: "N/A", review: "N/A", rating: 3.2, reviews: 423
            },
            {
                id: 6, titulo: "Diario de Greg", autor: "Jeff Kinney", sku: "F006", stock: true, categoria: "Infantil",
                precioActual: 877.00, precioAntiguo: 1170.00, discount: 25,
                imagen: "Images/diarioGreg.png", thumbnails: ["Images/diarioGreg.png", "Images/diarioGreg.png"],
                desc: "El primer libro de la saga.", info: "N/A", spec: "N/A", review: "N/A", rating: 5.0, reviews: 877
            }
        ];

        // === LÓGICA DE CARGA ===
        const params = new URLSearchParams(window.location.search);
        const pId = parseInt(params.get('id'));
        const p = productosDB.find(x => x.id === pId) || productosDB[0];

        if (p) {
            // 1. Info Básica
            document.getElementById('breadcrumb-title').textContent = p.titulo;
            document.getElementById('product-title').textContent = p.titulo;
            document.getElementById('meta-sku').textContent = p.sku;
            document.getElementById('meta-author').textContent = p.autor;
            document.getElementById('meta-category').textContent = p.categoria;

            const stockEl = document.getElementById('meta-stock');
            stockEl.textContent = p.stock ? "In Stock" : "Out of Stock";
            stockEl.className = "stock-status " + (p.stock ? "in-stock" : "out-stock");

            // 2. Imágenes
            const mainImg = document.getElementById('main-img');
            mainImg.src = p.imagen;
            mainImg.onerror = function () { this.src = 'https://via.placeholder.com/600x400?text=Sin+Imagen'; }; // Failsafe

            const thumbContainer = document.getElementById('thumbs-container');
            thumbContainer.innerHTML = '';
            p.thumbnails.forEach((src, i) => {
                let img = document.createElement('img');
                img.src = src;
                img.className = (i === 0) ? 'thumbnail active' : 'thumbnail';
                img.onclick = () => {
                    mainImg.src = src;
                    document.querySelectorAll('.thumbnail').forEach(t => t.classList.remove('active'));
                    img.classList.add('active');
                };
                img.onerror = function () { this.style.display = 'none'; }; // Ocultar si falla
                thumbContainer.appendChild(img);
            });

            // 3. Precio y Rating
            let priceHtml = `<span class="current-price">$${p.precioActual.toFixed(2)}</span>`;
            if (p.precioAntiguo) {
                priceHtml += `<span class="old-price">$${p.precioAntiguo.toFixed(2)}</span>`;
                priceHtml += `<span class="discount-badge">${p.discount}% OFF</span>`;
            }
            document.getElementById('price-block').innerHTML = priceHtml;

            document.getElementById('rating-block').innerHTML = `
                <span class="stars">${'★'.repeat(Math.floor(p.rating))}${'☆'.repeat(5 - Math.floor(p.rating))}</span>
                <span>${p.rating} Star Rating <span class="text-muted">(${p.reviews.toLocaleString()} User feedback)</span></span>
            `;

            // 4. Tabs
            document.getElementById('content-desc').innerHTML = p.desc;
            document.getElementById('content-info').innerHTML = p.info;
            document.getElementById('content-spec').innerHTML = p.spec;
            document.getElementById('content-review').innerHTML = p.review;
        }

        // === LÓGICA CARRUSEL ===
        document.querySelector('.prev-arrow').addEventListener('click', () => {
            document.getElementById('thumbs-container').scrollBy({ left: -100, behavior: 'smooth' });
        });
        document.querySelector('.next-arrow').addEventListener('click', () => {
            document.getElementById('thumbs-container').scrollBy({ left: 100, behavior: 'smooth' });
        });

        const minusBtn = document.getElementById('qty-minus');
        const plusBtn = document.getElementById('qty-plus');
        const qtyInput = document.getElementById('qty-input');

        // Verificamos que los elementos existan antes de añadir eventos
        if (minusBtn && plusBtn && qtyInput) {

            // Evento para el botón de restar (-)
            minusBtn.addEventListener('click', () => {
                let currentValue = parseInt(qtyInput.value, 10);
                if (currentValue > 1) {
                    qtyInput.value = currentValue - 1;
                }
            });

            // Evento para el botón de sumar (+)
            plusBtn.addEventListener('click', () => {
                let currentValue = parseInt(qtyInput.value, 10);
                qtyInput.value = currentValue + 1;
            });
        }
    });
</script>

</asp:Content>