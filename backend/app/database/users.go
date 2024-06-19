package database

import (
	"github.com/jackc/pgx/v5/pgtype"
)

type DBUser struct {
	Id            pgtype.UUID      `db:"id" `
	ServiceName   string           `db:"service_name"`
	ServiceUserId string           `db:"service_user_id"`
	Role          string           `db:"role"`
	DisplayName   string           `db:"display_name"`
	AvatarUrl     string           `db:"avatar_url"`
	CreatedOn     pgtype.Timestamp `db:"created_on" json:"-"`
}

// Roles
const (
	Admin = "ADMIN"
)

func CreateUser(serviceName string, serviceUserId string, serviceDisplayName string, avatarUrl string) DBUser {
	user, err := GetRow[DBUser](
		`INSERT INTO users (service_name, service_user_id, display_name, avatar_url)
		 VALUES ($1, $2, $3, $4)
		 ON CONFLICT (service_name, service_user_id)
		 DO UPDATE
		 SET display_name = $3, avatar_url = $4
		 RETURNING *`,
		serviceName, serviceUserId, serviceDisplayName, avatarUrl)
	if err != nil {
		logger.Error("error getting user: %v", err)
	}
	return user
}

func GetUser(userId pgtype.UUID) DBUser {
	user, err := GetRow[DBUser](
		`SELECT *
		 FROM users 
		 WHERE id = $1`,
		userId)
	if err != nil {
		logger.Error("error getting user: %v", err)
	}
	return user
}
