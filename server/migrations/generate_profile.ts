// seed.js

import { PrismaClient } from '@prisma/client';
import Profile from '../models/profile';

const prisma = new PrismaClient();

async function main() {
    const profile = Profile.example();

    await prisma.profile.create({
        data: {
            name: profile.name,
            surname: profile.surname,
            middlename: profile.middlename,
            dateborn: profile.dateBorn,
            avatarLink: profile.avatarLink
        }
    });
}

main()
    .catch(e => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();

        console.debug(`${Date.now()} - Inserted cars data!`);
    });