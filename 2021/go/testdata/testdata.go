package testdata

import (
	"bytes"
	"errors"
	"fmt"
	"io"
	"io/ioutil"
	"path/filepath"
	"runtime"

	"gopkg.in/yaml.v3"
)

type TestCase struct {
	Input  string `yaml:"input"`
	Output string `yaml:"output"`
}

func Get(day int, part int) (error, []TestCase) {
	file := filepath.Join(cwd(), fmt.Sprintf("../../test_data/day%d/part%d.yaml", day, part))
	content, err := ioutil.ReadFile(file)
	if err != nil {
		return err, nil
	}

	decoder := yaml.NewDecoder(bytes.NewReader(content))
	var (
		t  TestCase
		ts []TestCase
	)
	for {
		err := decoder.Decode(&t)
		if errors.Is(err, io.EOF) {
			break
		}
		if err != nil {
			return err, nil
		}
		ts = append(ts, t)
	}
	return nil, ts
}

func cwd() string {
	_, b, _, _ := runtime.Caller(0)
	return filepath.Dir(b)
}
