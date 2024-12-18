import express,
    {
        Request,
        Response
    } from 'express';

import { ROUTER_CARS } from '../routes/router_cars';
import { ROUTER_CART } from '../routes/router_cart';
import { ROUTER_FAVORITES } from '../routes/router_favorites';
import { ROUTER_PROFILES } from '../routes/router_profiles';
import { ROUTER_ORDERS } from '../routes/router_orders';

const app = express();

const PORT = process.env.PORT || 3000;

app.use(express.json());

app.use('/cars', 
    ROUTER_CARS);
app.use('/cart',
    ROUTER_CART);
app.use('/orders',
    ROUTER_ORDERS);
app.use('/profiles',
    ROUTER_PROFILES);
app.use('/favorites',
    ROUTER_FAVORITES);

app.listen(PORT, () => {
    console.log('Server is running on port: ' + PORT);
})