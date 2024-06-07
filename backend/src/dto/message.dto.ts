export interface messageDto {
    senderId: string;
    receiverId: string;
    message: string;
    type: string;
    tripId: number;
}

export interface messageUsersDto {
    user1Id: string;
    user2Id: string;
}