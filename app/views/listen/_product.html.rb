<div id="product-component-<%=content.productid%>"></div>
<p><script type="text/javascript">
/*<![CDATA[*/
(function () {
  var scriptURL = 'https://sdks.shopifycdn.com/buy-button/latest/buy-button-storefront.min.js';
  if (window.ShopifyBuy) {
    if (window.ShopifyBuy.UI) {
      ShopifyBuyInit();
    } else {
      loadScript();
    }
  } else {
    loadScript();
  }
  function loadScript() {
    var script = document.createElement('script');
    script.async = true;
    script.src = scriptURL;
    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(script);
    script.onload = ShopifyBuyInit;
  }
  function ShopifyBuyInit() {
    var client = ShopifyBuy.buildClient({
      domain: 'holland-baroque.myshopify.com',
      storefrontAccessToken: 'c25a3bbfc6a911dc208801bbc8a543eb',
    });
    ShopifyBuy.UI.onReady(client).then(function (ui) {
      ui.createComponent('product', {
        id: '7334198214809',
        node: document.getElementById('product-component-<%=content.productid%>'),
        moneyFormat: '%E2%82%AC%7B%7Bamount_with_comma_separator%7D%7D',
        options: {
  "product": {
    "styles": {
      "product": {
        "@media (min-width: 601px)": {
          "max-width": "calc(25% - 20px)",
          "margin-left": "20px",
          "margin-bottom": "50px"
        }
      },
      "title": {
        "font-family": "Montserrat, sans-serif",
        "color": "#000000"
      },
      "button": {
        "font-family": "Montserrat, sans-serif",
        ":hover": {
          "background-color": "#000000"
        },
        "background-color": "#000000",
        ":focus": {
          "background-color": "#000000"
        },
        "border-radius": "0px"
      },
      "price": {
        "font-family": "Montserrat, sans-serif",
        "color": "#000000"
      },
      "compareAt": {
        "font-family": "Montserrat, sans-serif",
        "color": "#000000"
      },
      "unitPrice": {
        "font-family": "Montserrat, sans-serif",
        "color": "#000000"
      }
    },
    "text": {
      "button": "Add to cart"
    },
    "googleFonts": [
      "Montserrat"
    ]
  },
  "productSet": {
    "styles": {
      "products": {
        "@media (min-width: 601px)": {
          "margin-left": "-20px"
        }
      }
    }
  },
  "modalProduct": {
    "contents": {
      "img": false,
      "imgWithCarousel": true,
      "button": false,
      "buttonWithQuantity": true
    },
    "styles": {
      "product": {
        "@media (min-width: 601px)": {
          "max-width": "100%",
          "margin-left": "0px",
          "margin-bottom": "0px"
        }
      },
      "button": {
        "font-family": "Montserrat, sans-serif",
        ":hover": {
          "background-color": "#000000"
        },
        "background-color": "#000000",
        ":focus": {
          "background-color": "#000000"
        },
        "border-radius": "0px"
      },
      "title": {
        "font-family": "Montserrat, sans-serif",
        "font-weight": "bold",
        "font-size": "30px",
        "color": "#000000"
      },
      "price": {
        "font-family": "Montserrat, sans-serif",
        "font-weight": "normal",
        "font-size": "18px",
        "color": "#000000"
      },
      "compareAt": {
        "font-family": "Montserrat, sans-serif",
        "font-weight": "normal",
        "font-size": "15.299999999999999px",
        "color": "#000000"
      },
      "unitPrice": {
        "font-family": "Montserrat, sans-serif",
        "font-weight": "normal",
        "font-size": "15.299999999999999px",
        "color": "#000000"
      },
      "description": {
        "font-family": "Montserrat, sans-serif",
        "color": "#000000"
      }
    },
    "googleFonts": [
      "Montserrat"
    ],
    "text": {
      "button": "In winkelwagen"
    }
  },
  "option": {},
  "cart": {
    "styles": {
      "button": {
        "font-family": "Montserrat, sans-serif",
        ":hover": {
          "background-color": "#000000"
        },
        "background-color": "#000000",
        ":focus": {
          "background-color": "#000000"
        },
        "border-radius": "0px"
      },
      "title": {
        "color": "#000000"
      },
      "header": {
        "color": "#000000"
      },
      "lineItems": {
        "color": "#000000"
      },
      "subtotalText": {
        "color": "#000000"
      },
      "subtotal": {
        "color": "#000000"
      },
      "notice": {
        "color": "#000000"
      },
      "currency": {
        "color": "#000000"
      },
      "close": {
        "color": "#000000",
        ":hover": {
          "color": "#000000"
        }
      },
      "empty": {
        "color": "#000000"
      },
      "noteDescription": {
        "color": "#000000"
      },
      "discountText": {
        "color": "#000000"
      },
      "discountIcon": {
        "fill": "#000000"
      },
      "discountAmount": {
        "color": "#000000"
      }
    },
    "text": {
      "total": "Total",
      "empty": "Shopping Cart is empty",
      "notice": "Shipping costs and discount codes will be added at checkout.",
      "button": "Checkout",
      "noteDescription": "Special instructions"
    },
    "contents": {
      "note": true
    },
    "googleFonts": [
      "Montserrat"
    ]
  },
  "toggle": {
    "styles": {
      "toggle": {
        "font-family": "Montserrat, sans-serif",
        "background-color": "#000000",
        ":hover": {
          "background-color": "#000000"
        },
        ":focus": {
          "background-color": "#000000"
        }
      }
    },
    "googleFonts": [
      "Montserrat"
    ]
  },
  "lineItem": {
    "styles": {
      "variantTitle": {
        "color": "#000000"
      },
      "title": {
        "color": "#000000"
      },
      "price": {
        "color": "#000000"
      },
      "fullPrice": {
        "color": "#000000"
      },
      "discount": {
        "color": "#000000"
      },
      "discountIcon": {
        "fill": "#000000"
      },
      "quantity": {
        "color": "#000000"
      },
      "quantityIncrement": {
        "color": "#000000",
        "border-color": "#000000"
      },
      "quantityDecrement": {
        "color": "#000000",
        "border-color": "#000000"
      },
      "quantityInput": {
        "color": "#000000",
        "border-color": "#000000"
      }
    }
  }
},
      });
    });
  }
})();
/*]]>*/
</script></p>


