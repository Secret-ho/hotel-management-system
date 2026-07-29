// Booking form: date/guest validation, price calculation,
// multi-step flow (Continue -> personal info -> Reserve), and submission to the API

const API_BASE = "http://localhost:5000/api";


export function initBookingForm() {
    const bookingForm = document.getElementById('bookingForm');
    if (!bookingForm) return;

    function onlyNumbers(input, maxLength) {
        input.addEventListener('input', function () {
            this.value = this.value.replace(/\D/g, '').slice(0, maxLength);
        });
    }

    const mobileEl = document.getElementById('mobile');
    const nationalIdEl = document.getElementById('nationalId');

    if (mobileEl) onlyNumbers(mobileEl, 11);
    if (nationalIdEl) onlyNumbers(nationalIdEl, 10);

    const checkinInput = document.getElementById('checkin');
    const checkoutInput = document.getElementById('checkout');
    const priceDisplay = document.getElementById('totalPrice');
    const guestsInput = document.getElementById('guests');
    const basePricePerNight = 550000;


    const today = new Date().toISOString().split('T')[0];
    if (checkinInput && checkoutInput) {
        checkinInput.min = today;
        checkinInput.addEventListener('change', () => {
            checkoutInput.min = checkinInput.value;
        });
    }



    guestsInput.addEventListener('input', () => {
        let val = parseInt(guestsInput.value, 10);

        if (!val || val < 1)
            guestsInput.value = 1;


        if (val > 10) {
            guestsInput.value = 10;
        } else if (val < 1) {
            guestsInput.value = 1;
        }
    });


    guestsInput.addEventListener('blur', () => {
        let val = parseInt(guestsInput.value, 10);
        if (isNaN(val) || val < 1) {
            guestsInput.value = 1;
        } else if (val > 10) {
            guestsInput.value = 10;
        }
    });



    function calculatePrice() {
        if (checkinInput.value && checkoutInput.value) {
            const checkin = new Date(checkinInput.value);
            const checkout = new Date(checkoutInput.value);
            const guests = parseInt(guestsInput.value) || 1;
            const days = Math.ceil((checkout - checkin) / (1000 * 3600 * 24));

            if (days > 0) {
                const total = days * basePricePerNight * guests;
                priceDisplay.innerText = `Total: ${total.toLocaleString('en-US')} Toman`;
                priceDisplay.dataset.total = total;
            } else {
                priceDisplay.innerText = "Check-out date is invalid";
                checkoutInput.value = "";
            }
        }
    }

    checkinInput.addEventListener('change', calculatePrice);
    checkoutInput.addEventListener('change', calculatePrice);
    guestsInput.addEventListener('input', calculatePrice);


    // Continue button shows personal info row
    const continueBtn = document.getElementById('continueBtn');
    const personalRow = document.getElementById('personalInfoRow');
    const submitBtn = bookingForm.querySelector('button[type="submit"]');

    if (personalRow) personalRow.classList.remove('open');

    if (continueBtn) {
        continueBtn.addEventListener('click', (e) => {
            e.preventDefault();
            calculatePrice();
            const total = parseFloat(priceDisplay.dataset.total || "0");
            if (!total || total <= 0) {
                alert("Please select valid dates.");
                return;
            }
            if (personalRow) {
                // start open animation
                personalRow.classList.add('open');
                personalRow.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
            continueBtn.disabled = true;

            // after the open animation completes, hide Continue and show Reserve
            const reserveBtn = document.getElementById('reserveBtn');
            const onTransitionEnd = (ev) => {
                if (ev.propertyName === 'max-height') {
                    try {
                        if (reserveBtn) {
                            reserveBtn.style.display = 'block';
                        }

                        continueBtn.style.display = 'none';

                    } catch (err) { /* ignore */ }
                    personalRow.removeEventListener('transitionend', onTransitionEnd);
                    if (submitBtn) submitBtn.focus();
                }
            };
            if (personalRow) personalRow.addEventListener('transitionend', onTransitionEnd);
        });
    }

    bookingForm.addEventListener('submit', async (e) => {
        e.preventDefault();

        // Read customer info from the form
        const firstName = document.getElementById('firstName').value.trim();
        const lastName = document.getElementById('lastName').value.trim();
        const nationalId = document.getElementById('nationalId').value.trim();
        const mobile = document.getElementById('mobile').value.trim();
        const total = parseFloat(priceDisplay.dataset.total || "0");
        if (!total || total <= 0) {
            alert("Please select valid dates.");
            return;
        }


        const submitBtn = bookingForm.querySelector('button[type="submit"]');
        submitBtn.textContent = "Submitting...";
        submitBtn.disabled = true;

        try {
            // Step 1: create the customer
            const customerRes = await fetch(API_BASE + "/customers", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    first_name: firstName,
                    last_name: lastName,
                    national_id: nationalId,
                    mobile_phone: mobile
                })
            });
            const customerData = await customerRes.json();

            if (!customerRes.ok) {
                alert("Error creating customer: " + (customerData.error || ""));
                return;
            }

            // Step 2: create the reservation
            const reservationRes = await fetch(API_BASE + "/reservations", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    reservation_number: "RES-" + Date.now(),
                    customer_id: customerData.customer_id,
                    room_id: 1,
                    check_in_date: checkinInput.value,
                    check_out_date: checkoutInput.value,
                    total: total
                })
            });
            const result = await reservationRes.json();

            if (reservationRes.ok) {
                alert(`✅ Your reservation was successful!\n\nName: ${firstName} ${lastName}\nCheck-in: ${checkinInput.value}\nCheck-out: ${checkoutInput.value}\nTotal: ${total.toLocaleString('en-US')} Toman`);
                bookingForm.reset();
                priceDisplay.innerText = "Total: 0 Toman";
            } else {
                alert("Error creating reservation: " + (result.error || "An error occurred"));
            }

        } catch (err) {
            alert("Error connecting to server. Please ensure the backend is running.");
            console.error(err);
        } finally {
            submitBtn.textContent = "Book Now";
            submitBtn.disabled = false;
        }
    });
}
