package faker

import (
	"crypto/rand"
	"fmt"
	"math/big"

	"github.com/lithammer/shortuuid/v3"

	"github.com/hadenlabs/terraform-aws-lambda-function/internal/errors"
)

type FakeFunction interface {
	Name() string // function fake
}

type fakeName struct{}

func Function() FakeFunction {
	return fakeName{}
}

var (
	names = []string{"lambda1", "lambda2"}
)

func (n fakeName) Name() string {
	num, err := rand.Int(rand.Reader, big.NewInt(int64(len(names))))
	if err != nil {
		panic(errors.New(errors.ErrorUnknown, err.Error()))
	}
	nameuuid := fmt.Sprintf("%s-%s", names[num.Int64()], shortuuid.New())
	return nameuuid
}
