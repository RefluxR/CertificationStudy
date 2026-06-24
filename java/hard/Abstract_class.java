package hard;
public class Abstract_class {

    public abstract class Animal{

        String name;
        Animal(String name){
            this.name = name;
        }

        abstract void breathe(); // 추상 메서드는 선언만 하고 기능 구현 X
                                // 추상 클래스를 상속받는 자식 클래스의 
                                // 주제에 따라서 상속 받는 메서드의 내용이 달라질 수 있기 때문


        // 즉, 클래스의 선언부에 abstract 키워드가 있다는 말은 안에 
        // 추상 메서드(abstract method)가 있으니 상속을 통해서 구현해주라는 지침 

    }

    class Dog extends Animal{
        Dog(String name){
            super(name);
        }
        //@Override
        void breathe() {
            System.out.println("헥헥헥");  
        }
    }   

}
