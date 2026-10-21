document.addEventListener("DOMContentLoaded", function () {

    /*
     * AVAILABLE FOOD SEARCH AND CATEGORY FILTER
     */
    const foodSearch = document.getElementById("foodSearch");
    const foodCategoryFilter = document.getElementById("foodCategoryFilter");
    const availableFoodGrid = document.getElementById("availableFoodGrid");
    const noFoodResults = document.getElementById("noFoodResults");

    function filterFood() {
        if (!availableFoodGrid) return;

        const searchTerm = foodSearch
            ? foodSearch.value.toLowerCase().trim()
            : "";

        const selectedCategory = foodCategoryFilter
            ? foodCategoryFilter.value
            : "all";

        const cards = availableFoodGrid.querySelectorAll(".food-card");
        let visibleCount = 0;

        cards.forEach(function (card) {
            const cardText = card.textContent.toLowerCase();
            const cardCategory = card.dataset.category || "";

            const matchesSearch = cardText.includes(searchTerm);
            const matchesCategory =
                selectedCategory === "all" ||
                cardCategory === selectedCategory;

            const visible = matchesSearch && matchesCategory;

            card.hidden = !visible;

            if (visible) {
                visibleCount++;
            }
        });

        if (noFoodResults) {
            noFoodResults.hidden = visibleCount !== 0;
        }
    }

    if (foodSearch) {
        foodSearch.addEventListener("input", filterFood);
    }

    if (foodCategoryFilter) {
        foodCategoryFilter.addEventListener("change", filterFood);
    }

    /*
     * MY REQUESTS SEARCH AND STATUS FILTER
     */
    const requestSearch = document.getElementById("requestSearch");
    const requestStatusFilter = document.getElementById("requestStatusFilter");
    const requestsTable = document.getElementById("requestsTable");
    const noRequests = document.getElementById("noRequests");

    function filterRequests() {
        if (!requestsTable) return;

        const searchTerm = requestSearch
            ? requestSearch.value.toLowerCase().trim()
            : "";

        const selectedStatus = requestStatusFilter
            ? requestStatusFilter.value
            : "all";

        const rows = requestsTable.querySelectorAll("tbody tr");
        let visibleCount = 0;

        rows.forEach(function (row) {
            const rowText = row.textContent.toLowerCase();
            const rowStatus = row.dataset.status || "";

            const matchesSearch = rowText.includes(searchTerm);
            const matchesStatus =
                selectedStatus === "all" ||
                rowStatus === selectedStatus;

            const visible = matchesSearch && matchesStatus;

            row.hidden = !visible;

            if (visible) {
                visibleCount++;
            }
        });

        if (noRequests) {
            noRequests.hidden = visibleCount !== 0;
        }
    }

    if (requestSearch) {
        requestSearch.addEventListener("input", filterRequests);
    }

    if (requestStatusFilter) {
        requestStatusFilter.addEventListener("change", filterRequests);
    }

    /*
     * FOOD REQUEST FORM
     * Frontend demo only; it does not save anything to Oracle.
     */
    const foodRequestForm = document.getElementById("foodRequestForm");

    if (foodRequestForm) {
        const quantityInput = document.getElementById("requestedQuantity");
        const quantityError = document.getElementById("requestedQuantityError");
        const requestFormMessage = document.getElementById("requestFormMessage");

        function validateQuantity() {
            const quantity = Number(quantityInput.value);

            if (
                quantityInput.value.trim() === "" ||
                !Number.isInteger(quantity) ||
                quantity < 1 ||
                quantity > 20
            ) {
                quantityError.textContent =
                    "Enter a whole number between 1 and 20 servings.";
                quantityInput.classList.add("invalid");
                quantityInput.setAttribute("aria-invalid", "true");
                return false;
            }

            quantityError.textContent = "";
            quantityInput.classList.remove("invalid");
            quantityInput.setAttribute("aria-invalid", "false");
            return true;
        }

        quantityInput.addEventListener("input", function () {
            if (quantityInput.classList.contains("invalid")) {
                validateQuantity();
            }
        });

        foodRequestForm.addEventListener("submit", function (event) {
            event.preventDefault();

            if (!validateQuantity()) {
                requestFormMessage.textContent =
                    "Please correct the quantity before submitting.";
                requestFormMessage.className = "form-message error";
                quantityInput.focus();
                return;
            }

            const confirmed = window.confirm(
                "Submit this food request in the frontend demo?"
            );

            if (!confirmed) return;

            requestFormMessage.textContent =
                "Frontend validation successful! Backend integration is pending; the request has not been saved.";
            requestFormMessage.className = "form-message success";
        });
    }

});