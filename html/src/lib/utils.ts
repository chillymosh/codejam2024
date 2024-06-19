export function getDiscordAvatarUrl(userId: string, avatarHash: string): string {
	return "https://cdn.discordapp.com/avatars/" + userId + "/" + avatarHash + ".png?size=48";
}