package database

import (
	"github.com/jackc/pgx/v5/pgtype"
)

type DBUser struct {
	// step 1 create User
	Id            pgtype.UUID      `db:"id" `
	ServiceName   string           `db:"service_name"`
	ServiceUserId string           `db:"service_user_id" json:"-"`
	DisplayName   string           `db:"display_name"`
	CreatedOn     pgtype.Timestamp `db:"created_on" json:"-"`
}

func CreateUser(serviceName string, serviceUserId string, serviceDisplayName string) DBUser {
	// step 2 create user
	user, err := GetRow[DBUser](
		`INSERT INTO users (service_name, service_user_id, display_name)
		 VALUES ($1, $2, $3)
		 ON CONFLICT (service_name, service_user_id)
		 DO UPDATE
		 SET display_name = $3
		 RETURNING *`,
		serviceName, serviceUserId, serviceDisplayName)
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
