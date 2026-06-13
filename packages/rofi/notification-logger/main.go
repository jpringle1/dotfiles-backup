package main

import (
	"encoding/json"
	"log"
	"os"
	"path/filepath"
	"time"

	"github.com/godbus/dbus/v5"
)

type entry struct {
	Time    string `json:"time"`
	App     string `json:"app"`
	Summary string `json:"summary"`
	Body    string `json:"body"`
}

func logDir() string {
	if d := os.Getenv("XDG_DATA_HOME"); d != "" {
		return filepath.Join(d, "notification-history")
	}
	return filepath.Join(os.Getenv("HOME"), ".local", "share", "notification-history")
}

func main() {
	dir := logDir()
	if err := os.MkdirAll(dir, 0755); err != nil {
		log.Fatal(err)
	}

	f, err := os.OpenFile(filepath.Join(dir, "history.jsonl"), os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()

	conn, err := dbus.ConnectSessionBus()
	if err != nil {
		log.Fatal(err)
	}
	defer conn.Close()

	if err := conn.BusObject().Call(
		"org.freedesktop.DBus.Monitoring.BecomeMonitor", 0,
		[]string{"type='method_call',interface='org.freedesktop.Notifications',member='Notify'"},
		uint32(0),
	).Err; err != nil {
		log.Fatal(err)
	}

	ch := make(chan *dbus.Message, 16)
	conn.Eavesdrop(ch)

	enc := json.NewEncoder(f)
	for msg := range ch {
		if msg.Type != dbus.TypeMethodCall || len(msg.Body) < 5 {
			continue
		}
		app, _ := msg.Body[0].(string)
		summary, _ := msg.Body[3].(string)
		body, _ := msg.Body[4].(string)
		if app == "" && summary == "" {
			continue
		}
		enc.Encode(entry{
			Time:    time.Now().Format("2006-01-02 15:04"),
			App:     app,
			Summary: summary,
			Body:    body,
		})
	}
}
