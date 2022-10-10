package faker

import (
	"reflect"

	fakerTag "github.com/bxcodec/faker/v3"
)

func Generator() {
	_ = fakerTag.AddProvider("functionNameFaker", func(v reflect.Value) (interface{}, error) {
		return Function().Name(), nil
	})
}
