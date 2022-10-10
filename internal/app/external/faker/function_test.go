package faker

import (
	"testing"

	"strings"

	"github.com/stretchr/testify/assert"
)

func TestFakeFunctionName(t *testing.T) {
	name := Function().Name()
	namePrefix := strings.Split(name, "-")[0]
	assert.Contains(t, names, namePrefix, namePrefix)
}
