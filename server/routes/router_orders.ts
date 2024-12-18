import express, { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';

export const ROUTER_ORDERS = express.Router();

const prisma = new PrismaClient();

ROUTER_ORDERS.get('/', async (req: Request, res: Response) => {
    try {
        const profileId = Number(req.body.id_profile);

        const orders = await prisma.orders.findMany({
            where: { profile_id: profileId },
            include: {
                Cart: {
                    include: { Car: true }
                }
            }
        });

        if (orders.length > 0) {
            res.status(200).json(orders);
        } else {
            res.status(404).json({ message: 'No orders found for this profile.' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error.', error });
    }
});

ROUTER_ORDERS.get('/:id', async (req: Request, res: Response) => {
    try {
        const orderId = Number(req.params.id);
        const profileId = Number(req.body.id_profile);

        const order = await prisma.orders.findUnique({
            where: { id: orderId, profile_id: profileId },
            include: {
                Cart: {
                    include: { Car: true }
                }
            }
        });

        if (order) {
            res.status(200).json(order);
        } else {
            res.status(404).json({ message: 'Order not found.' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error.', error });
    }
});

ROUTER_ORDERS.post('/', async (req: Request, res: Response) => {
    try {
        const profileId = Number(req.body.id_profile);

        const carts = await prisma.cart.findMany({
            where: { id_profile: profileId, is_ordered: false }
        });

        console.log(profileId, carts);

        if (carts.length === 0) {
            res.status(400).json({ message: 'No items in the cart to place an order.' });
            return;
        }

        const newOrder = await prisma.orders.create({
            data: {
                profile_id: profileId
            }
        });

        await prisma.cart.updateMany({
            where: { id_profile: profileId, is_ordered: false },
            data: {
                order_id: newOrder.id,
                is_ordered: true
            }
        });

        res.status(201).json({ message: 'Order placed successfully.', orderId: newOrder.id });
    } catch (error) {
        res.status(500).json({ message: 'Internal server error.', error });
        console.error(error);
    }
});
