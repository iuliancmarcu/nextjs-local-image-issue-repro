import Image from "next/image";

function Homepage() {
  return (
    <>
      <h1>There should be an image under this title</h1>
      <Image
        alt="example image"
        src="/images/example.jpg"
        width={400}
        height={400}
      />
    </>
  );
}

export default Homepage;
